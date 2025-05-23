import cv2
from triton.runtime import driver

from ultralytics import YOLO
from ultralytics.utils.plotting import Annotator, colors

# model = YOLO("/home/hyl/Projects/hylreg/Data/YOLO/models/yolo11n.pt")
model = YOLO("/home/hyl/Projects/hylreg/Data/YOLO/models/yolo11n.onnx")

names = model.names

cap = cv2.VideoCapture(0)
assert cap.isOpened(), "Error reading video file"
w, h, fps = (int(cap.get(x)) for x in (cv2.CAP_PROP_FRAME_WIDTH, cv2.CAP_PROP_FRAME_HEIGHT, cv2.CAP_PROP_FPS))

# Blur ratio
blur_ratio = 50

# Video writer
# video_writer = cv2.VideoWriter("object_blurring_output.avi", cv2.VideoWriter_fourcc(*"mp4v"), fps, (w, h))

prev_time = 0  # 用于计算FPS

while cap.isOpened():
    success, im0 = cap.read()
    if not success:
        print("Video frame is empty or video processing has been successfully completed.")
        break

    # 计算FPS
    current_time = cv2.getTickCount()
    fps = cv2.getTickFrequency() / (current_time - prev_time) if prev_time != 0 else 0
    prev_time = current_time

    # 在图像左上角显示FPS（白色文字）
    cv2.putText(im0, f"FPS: {int(fps)}", (10, 30),
    cv2.FONT_HERSHEY_SIMPLEX, 0.7, (255, 255, 255), 2)

     # 打印帧率
    print(f"FPS: {int(fps)}")


    results = model.predict(im0, show=False,device="0")
    # results = model.predict(im0, show=False,device="cpu")

    boxes = results[0].boxes.xyxy.cpu().tolist()
    clss = results[0].boxes.cls.cpu().tolist()
    annotator = Annotator(im0, line_width=2, example=names)

    if boxes is not None:
        for box, cls in zip(boxes, clss):
            annotator.box_label(box, color=colors(int(cls), True), label=names[int(cls)])

            obj = im0[int(box[1]) : int(box[3]), int(box[0]) : int(box[2])]
            blur_obj = cv2.blur(obj, (blur_ratio, blur_ratio))

            im0[int(box[1]) : int(box[3]), int(box[0]) : int(box[2])] = blur_obj

    cv2.imshow("ultralytics", im0)
    # video_writer.write(im0)
    if cv2.waitKey(1) & 0xFF == ord("q"):
        break

cap.release()
# video_writer.release()
cv2.destroyAllWindows()