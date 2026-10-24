# Remote ARS nRF52840 — Rev J, nguồn mua tại TP.HCM

Cập nhật 02/10/2026. PCB đã sửa và đi dây lại, có Gerber/drill cho đặt mẫu. KiCad 10.0.6. Đây là thiết kế CAD đã kiểm tra; chưa có kết quả chạy phần cứng hoặc firmware.

## Thay đổi so với Rev I.1

- Bỏ TPS61099DRVR, cuộn cảm SRN4018-2R2M, R19 1MΩ, R20 249kΩ và tụ đầu ra C3/C4 trên PCB.
- U1 trở thành **module tăng áp USB ngoài bo**, mua ở IC Đây Rồi. Không cần mua các món LCSC của khối nguồn cũ.
- Thêm **J5** đưa nguồn AA đã qua công tắc/chống ngược ra module; **J6** nhận 5V từ USB-A của module. Giữ **J4** cho dây USB-C đực cấp vào SuperMini.
- Giữ C1 22µF ở đầu vào, C2/C5 trên rail logic, Q1 chống ngược pin, SW15 trên bo, 14 nút nhấn hai chân, LED 3261BS và bố trí module nRF trên chân thấp.
- PCB giữ **68×80mm, hai lớp**. Mọi track 0,25mm; clearance khác net ≥0,23mm; zone GND và thermal gap 0,508mm.

## Mua linh kiện nguồn

| Món | Số lượng/remote | Giá đối chiếu | Nơi mua |
|---|---:|---:|---|
| Module boost 0,9–5V lên 5V USB, shop ghi 34×16,2mm | 1 | 10.000đ | [IC Đây Rồi](https://icdayroi.com/mach-nguon-tang-ap-dc-0-9-5v-sang-5v-usb) |
| Dây USB-A đực nối XH2.54 hai chân, 50cm IC20985 | 1 | 26.220đ | [Thế Giới IC](https://www.thegioiic.com/day-usb-type-a-duc-noi-xh2-54-2-chan-dai-50cm) |
| Dây USB-C đực hai lõi 75mm IC41762, giữ từ Rev I | 1 | 7.980đ, giá kế thừa | [Thế Giới IC](https://www.thegioiic.com/day-cap-usb-type-c-duc-2-chan-dai-75mm) |

Dây USB-A cắt bỏ đầu XH và rút ngắn theo vị trí lắp. Dùng đoạn hai lõi dư để nối J5 với IN của module, không cần mua riêng dây đầu vào trong dự toán. Giữ đầu USB-A và đầu USB-C nguyên vẹn. Chừa đoạn dây chống kéo ở từng chỗ hàn. Giá nguồn mới đối chiếu ngày 02/10/2026; các món còn lại giữ dữ liệu BOM trước, gọi shop kiểm tra tồn và giá trước khi đến.

IC Đây Rồi: 0385 593 358, số 4 Đường số 7, khu phố 3, Linh Trung, Thủ Đức, theo địa chỉ shop công bố. Thế Giới IC: 028 2205 6688 / 0972 924 961, 939/1A Kha Vạn Cân, phường Linh Xuân, TP.HCM.

## Đấu nguồn lên PCB

**2AA → BT1 → SW15 → Q1 → J5 → IN module boost → USB-A module → dây USB-A → J6 → J4 → dây USB-C → SuperMini.**

| Điểm PCB | Net / chức năng | Đấu thực tế |
|---|---|---|
| BT1.1 | AA_RAW | Dây đỏ khay pin |
| BT1.2 | GND | Dây đen khay pin |
| SW15.2 | COM, AA_RAW | Đã đi dây trên PCB |
| SW15.3 | AA_SW | Đã đi dây sang Q1 |
| SW15.1 / 4 / 5 | OFF / giữ cơ khí | Không nối thêm dây điện |
| **J5.1** | **VIN_AA, nguồn AA đã bảo vệ** | Đến **IN+** module boost |
| **J5.2** | **GND** | Đến **IN−** module boost |
| **J6.1** | **USB_5V** | Dây VBUS của USB-A đực, thường đỏ |
| **J6.2** | **GND** | Dây GND của USB-A đực, thường đen |
| **J4.1** | **USB_5V** | Dây VBUS của USB-C đực |
| **J4.2** | **GND** | Dây GND của USB-C đực |
| J3.1 B+ | NC | Để trống; không nối pin AA vào mạch sạc |
| J3.4 VCC | Rail logic đầu ra module nRF | Không cấp 5V vào đây |

Pad 1 của mỗi cặp dây J4/J5/J6 là pad vuông. KiCad và PDF schematic ghi rõ tên net. J5/J6 là các **lỗ hàn dây**, không phải footprint cắm trực tiếp module boost. Khoảng cách hai lỗ 4,6mm, lỗ khoan 0,9mm như footprint J4 kế thừa. Module boost không có bản vẽ chân/chiều cao xác nhận nên **không giả định vị trí pad theo ảnh shop**: xác định đúng IN+/IN− trên mẫu thật. Dùng đồng hồ đo thông mạch giữa dây và VBUS/GND ở đầu USB trước khi cấp điện; không chỉ dựa vào màu dây.

U1 trên schematic có bốn chân **logic** IN+, IN−, USB_VBUS, USB_GND để mô tả toàn bộ đường nguồn. Các số 1–4 không phải số chân hàn của một IC hoặc pinout vật lý module. U1 là linh kiện ngoài bo, nên không có footprint U1 trên PCB.

OFF ngắt pin trước module boost. Để nạp bằng máy tính: **rút đầu USB-C nguồn pin khỏi SuperMini**, sau đó cắm cáp PC vào cùng cổng. Không nối hai nguồn 5V song song. Thay cả cặp AA khi yếu; không sạc pin dùng một lần. Không dùng pin 14500 Li-ion trong khay AA.

## Lắp mỏng và giữ module

Đặt module boost **cạnh PCB trong khoang cách điện**, không xếp lên PCB hoặc lên pin. Dùng gá/kẹp hoặc băng dính xốp cách điện cố định chắc module và chống kéo dây. Không để mặt hàn chạm pin, lò xo khay, vít hoặc bo khác. Không cần tháo cổng USB-A trên module; dùng dây USB-A đã chọn để tránh phải hàn lên pad output chưa có bản vẽ.

Khay AA 57,5×30×12,5mm là kích thước shop ghi cho khay. Khi lắp pin, đường kính AA khoảng 14,5mm chi phối độ dày. Module boost 34×16,2mm **chưa tính phần đầu USB-A đực cắm vào**, chiều cao toàn cụm chưa xác minh. Vì vậy vỏ phải tăng diện tích ngang/dọc theo mẫu thật, giữ mục tiêu độ dày 18–20mm nếu toàn bộ cụm linh kiện cho phép. **Không dùng kích thước vỏ 76×124×20mm của Rev I để đặt in ngay**: Rev J chưa có CAD vỏ hoặc xác nhận lắp vừa. Không bố trí module nguồn, pin hoặc dây che vùng anten nRF ở đầu dưới bo.

Hàn SuperMini bằng hai hàng chân đực thấp, khe mục tiêu 2,5–3mm, đo linh kiện mặt dưới trước hàn. LED và nút nhấn giữ đúng footprint Rev I. Shop bán LED/nút generic nên kiểm tra mẫu trước khi lắp hàng loạt.

## Thử nguồn trước khi lắp nRF

1. Khi chưa có pin, đo không chập J5.1–GND hoặc J6.1–GND; xác nhận J6.1 thông J4.1 và J6.2 thông J4.2. Kiểm tra SW15 và chiều Q1.
2. Dùng nguồn giới hạn dòng để thử BT1 ở 3,0V. Bật SW15, đo cực và điện áp **5V ở đầu USB-C**, sau đó thử tải dự kiến trước nối SuperMini.
3. Lắp nRF, thử LED và BLE cùng lúc. Đo điện áp/ripple, khởi động và dòng ở đầu pin với 3,2V, 3,0V, 2,4V và 2,0V. Nếu nguồn sụt hoặc module reset thì tăng ngưỡng thay pin; không cố dùng tới mức 0,9V quảng cáo của shop.
4. Kiểm tra OFF làm mất điện từ pin; thử đảo cực bằng nguồn giới hạn dòng để kiểm Q1. Đo nhiệt của boost/Q1 và độ ổn định khi bấm/phát BLE.
5. Đo dòng trung bình theo lịch dùng thật rồi nhập vào sheet Thong so của BOM. Thời lượng xấp xỉ dung lượng sử dụng (mAh) / dòng trung bình đầu pin (mA). Đây là khảo sát, không phải bảo đảm thời gian thay pin.

Shop quảng cáo 600mA nhưng không công bố điều kiện điện áp đầu vào, IQ, đồ thị hiệu suất, ripple hoặc datasheet hãng. Thiết kế dùng module này để có thể mua/lắp tại chỗ; **không khẳng định hiệu suất/thời lượng tương đương TPS61099**. Giữ công tắc cơ và tắt ngoài giờ. Không có tự ngắt pin yếu trong Rev J.

## Breadboard

BOM breadboard đã đổi MT3608 sang đúng module boost USB Rev J, thêm dây USB-A. Có thể nối VBUS/GND dây USB-A với dây USB-C trực tiếp qua mối nối cách điện khi chưa có PCB. Muốn kiểm chống ngược pin thì dùng Q1 AO3401A trên adapter SOT-23 hoặc trên PCB mẫu; không thay Q1 bằng 2N3906. Switch bước 3mm cần dây/bo adapter, không ép vào breadboard 2,54mm.

Q2/Q3 breadboard dùng 2N3906 để thử chức năng LED; dòng base/sụt áp PNP khác MOSFET của PCB. Do đó việc dùng cùng module nguồn vẫn chưa làm dòng pin breadboard đại diện chính xác cho PCB. Tổng nguồn AA mua tròn gói là 75.770đ, chưa gồm Q1/adapter, vật tư gá, dây jumper và ship. Tổng thử USB và tổng nguồn AA là hai khoản riêng, không cộng nhầm thành chi phí một remote sản xuất.

## Kiểm tra CAD và ngân sách

| Mục | Kết quả |
|---|---:|
| ERC | 0 vi phạm |
| DRC sau refill | 0 vi phạm |
| Đường chưa nối | 0 |
| Schematic parity | 0 sai lệch |
| Track | 0,25mm |
| Clearance tối thiểu | 0,23mm |
| GND zone / thermal gap | 0,508mm |
| DRC exclusions | Không có |
| Linh kiện phân bổ mỗi remote, gồm hai AA và dây USB-A/USB-C | **251.795đ** |
| Dư so với trần linh kiện 300.000đ | **48.205đ** |

Giữ các mức ignore DRC của bản trước (courtyard thiếu, loại footprint, lỗ trong courtyard, một số kiểm tra tuning/endpoint). Không tắt kiểm tra clearance, ngắn mạch, kết nối hoặc parity. Báo cáo máy nằm trong verification. Đây là kiểm tra dữ liệu CAD; vẫn cần kiểm mẫu thật và chạy phần cứng trước sản xuất hàng loạt.

Chi phí chưa gồm PCB, vỏ, vật tư gá module, VAT và vận chuyển. Kế hoạch BOM giữ 5 remote + linh kiện dự phòng cho 1 bộ, có công thức làm tròn gói. Không phải xác nhận đã đặt hàng. R19/R20 có dòng số lượng 0 để giữ cấu trúc/công thức BOM, **không mua hoặc lắp**.

## File đặt PCB

Mở ARS_clicker_nRF.kicad_pro trong KiCad 10; thư viện riêng nằm cùng project. Gerber/drill trong gerber_prototype là bản Rev J, không dùng Gerber Rev I cũ. Thông số: **2 mặt sợi FR-4, 68×80mm, dày 1,6mm, đồng 1oz, phủ xanh lá hai mặt, in ký hiệu trắng hai mặt, lỗ xuyên mạ**. Đặt mẫu thử trước khi đặt hàng loạt. Bộ này không gồm vỏ đã thiết kế hoặc firmware.
