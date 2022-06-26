CREATE TABLE HOADON(
SOHD INT ,
MAKH INT ,
MANV INT,
PRIMARY KEY (MAKH, MANV) ,
NGAYMUA DATE 
);

CREATE TABLE HOADONCT(
SOHD INT,
MASP INT ,
PRIMARY KEY (SOHD ,MASP),
SOLUONG INT
)

 

                        
-- câu 1:
select count(distinct ct.masp) as 'Số sp khác nhau'
from hoadon HD join cthd CT on HD.sohd = CT.sohd 
where year(HD.nghd) = 2006  ;

-- câu 2:
select max(hoadon.trigia) as 'Bill Max', min(hoadon.trigia) as 'Bill Min'
from hoadon; 

-- câu 3:
select avg(hoadon.trigia) as 'avg bill in 2006'
from hoadon
where year(hoadon.nghd) = 2006 ;

-- câu 4:
select sum(hoadon.trigia) as 'Sum bill in 2006'
from hoadon
where year(hoadon.nghd) = 2006 ;

-- câu 5:
select max(hoadon.trigia) as 'Bill Max in 2006'
from hoadon
where year(nghd) = 2006; 

-- câu 6:
select KH.hoten, max(HD.trigia)
from khachhang KH join hoadon HD on KH.makh = hd.makh
where year(nghd) = 2006;

-- câu 7:
select KH.makh,KH.hoten
from khachhang kh
order by kh.doanhso desc
limit 3;

-- câu 8:
select masp, tensp, gia
from sanpham
where gia >= (
select distinct gia from sanpham
order by gia desc
limit 2,1
);

-- câu 9:
select masp, tensp, gia
from sanpham
where nuocsx like 'ý' and gia >= (
select distinct gia from sanpham
order by gia desc
limit 2,1
);

-- câu 10:
select masp, tensp, gia
from sanpham
where nuocsx like 'trung quốc' and gia >= (
select distinct gia from sanpham
order by gia desc
limit 2,1
);

-- câu 11:
Select *, rank() over(order by doanhso DESC) as ranking from khachhang;

-- câu 12:
select count(masp) 'số sp do ý sx' 
from sanpham
where nuocsx like 'ý';

-- câu 13:
select nuocsx, count(masp) "số sp sx" 
from sanpham
group by nuocsx;

-- câu 14:
select nuocsx , min(gia) as 'gia sp min', max(gia) as 'gia sp max', avg(gia) as 'gia sp avg' 
from sanpham
group by nuocsx;

-- câu 15:
select nghd as 'Ngày', sum(trigia) as 'Doanh thu'
from hoadon
group by nghd
order by nghd;

-- câu 16:
select count(cthd.sl) ' Số lượng bán ra'
from cthd join hoadon on hoadon.sohd = cthd.sohd
where month(nghd) = 10 and year(nghd) = 2006;

-- câu 17:
select month(nghd) as 'tháng', sum(trigia) as 'doanh thu'
from hoadon
where year(nghd) = 2006
group by month(nghd)
order by month(nghd);

-- câu 18:
select hoadon.sohd , count(cthd.masp) as 'so sp'
from hoadon join cthd on cthd.sohd = hoadon.sohd
group by hoadon.sohd
having count(cthd.masp) = 3 ;

-- câu 19:
select hoadon.sohd , count(cthd.masp) as 'so sp'
from hoadon join cthd on cthd.sohd = hoadon.sohd join sanpham on sanpham.masp = cthd.masp
where sanpham.nuocsx = 'việt nam'
group by hoadon.sohd
having count(cthd.masp) = 3 ;

-- câu 20:
select khachhang.makh, khachhang.hoten,count(hoadon.sohd)
from khachhang join hoadon on hoadon.makh = khachhang.makh
group by khachhang.makh
having count(hoadon.sohd) = (
select count(sohd)
from hoadon
group by makh
order by count(sohd) desc
limit 1
);

-- câu 21:
select month(nghd) as 'tháng', sum(trigia) as 'doanh thu'
from hoadon
where year(nghd) = 2006
group by month(nghd)
having sum(trigia) = (
select sum(trigia)
from hoadon
where year(nghd) = 2006
group by month(nghd)
order by sum(trigia) desc
limit 1);

-- câu 22: 
select sanpham.masp, sanpham.tensp, count(cthd.sl) as 'số lượng bán ra'
from sanpham join cthd on cthd.masp = sanpham.masp join hoadon on hoadon.sohd = cthd.sohd 
where year(hoadon.nghd) = 2006
group by sanpham.masp
having count(cthd.sl) = (
select count(cthd.sl)
from cthd
group by masp
order by count(cthd.sl)
limit 1
);

-- câu 23:
select sanpham.masp, sanpham.tensp 