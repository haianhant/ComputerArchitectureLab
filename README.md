# Computer Architecture Lab

Các bài tập cho môn Kiến trúc Máy tính (Computer Architecture).

Nội dung chính:
- Các bài tập theo tuần và bài tập giữa kỳ nằm trong các thư mục `Week*` và `Midterm_*`.
- Thư mục `Lab/` chứa file đề bài bài tập tổng hợp của môn.

Hướng dẫn nhanh
- Các file có đuôi `.asm` là mã Assembly dành cho các bài tập của môn. Kiến trúc và trình dịch/giả lập cụ thể có thể khác nhau tùy yêu cầu của giảng viên.
- Để chạy/kiểm tra mã Assembly, sử dụng trình assembler/giả lập phù hợp mà giảng viên yêu cầu. Ví dụ thông dụng:
	- RISC‑V: RARS v1.6 (RISC‑V Assembler and Runtime Simulator — tương tự MARS cho MIPS).
	  - Tải RARS v1.6: https://github.com/TheThirdOne/rars/releases/download/v1.6/rars1_6.jar
	  - Repo RARS: https://github.com/TheThirdOne/rars
	  - Yêu cầu: Java 8 hoặc cao hơn (JRE/JDK). Nếu máy chưa có Java, tải tại: https://www.oracle.com/java/technologies/downloads/
	  - Chạy nhanh (PowerShell / terminal):
	    - `java -jar rars1_6.jar` (mở GUI RARS)
	    - Trong RARS: `File -> Open` chọn file `.asm`, sau đó `Tools/Run` hoặc dùng các nút `Assemble`/`Simulate` để chạy/step từng lệnh.
	- x86 (Windows): MASM hoặc các công cụ tương đương
	- x86 (NASM): `nasm` + `ld` (trên hệ thống tương thích)

Tác giả phần bài làm
- Nguyen Huu Hoang Hai Anh (MSSV: 20226010). 

