Return-Path: <keng_629@126.com>
Received: from m5-141.126.com (m5-141.126.com [202.108.5.141])
	by ozlabs.org (Postfix) with SMTP id 056FDDDEC5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 19 Oct 2007 09:27:13 +1000 (EST)
Date: Fri, 19 Oct 2007 07:27:35 +0800
From: "keng_629" <keng_629@126.com>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
	<13252272.post@talk.nabble.com>
	<fa686aa40710170754p54aa405au9b046f7039ecb9ac@mail.gmail.com>
	<13259685.post@talk.nabble.com>
	<fa686aa40710171123uefac227q4fecd64516794129@mail.gmail.com>
Subject: =?gb2312?B?16q3ojogUmU6IExpbnV4IGJvb3RpbmcgcHJvYmxlbSBvbiBYaWxpbnggcHBj?=
Message-ID: <200710190727350936800@126.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="=====003_Dragon125864718448_====="
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.

--=====003_Dragon125864718448_=====
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: 7bit


On  10/17/07,  aauer1   <aauer1@gmx.at >  wrote:
>
>
>  Grant  Likely-2  wrote:
>   >
>   >  On  10/17/07,  aauer1   <aauer1@gmx.at >  wrote:
>   > >  Now,  I  know  that  the  kernel  boots  but  I  don't  get  an  output  with  my
>   > >  Xilinx
>   > >  UartLite  module.  Are  there  some  kernel  modules  which  must  be  activated??
>   > >  Btw.  I  have  used  the  Linux-2.6-virtex  kernel  from
>   > >  http://git.secretlab.ca/git/  and  another  Kernel  (2.6.23  from  kernel.org)
>   > >  -
>   > >  both  with  the  same  result.
>   >
>   >  Post  the  output  of  __log_buf  here  please.
>   >
>   >
>
>  Here  is  my  dump  of  the  __log_buf:
>  ======================
>   <5 >[        0.000000]  Linux  version  2.6.23-rc2
>  (aauer@servitus.student.iaik.tugraz.at)  (gcc  version  4.0.0  (DENX  ELDK  4.1
>  4.0
>  .0))  #8  Wed  Oct  17  20:05:28  CEST  2007
>   <6 >[        0.000000]  Xilinx  ML403  Reference  System  (Virtex-4  FX)
>   <7 >[        0.000000]  Entering  add_active_range(0,  0,  16384)  0  entries  of  256
>  used
>   <4 >[        0.000000]  Zone  PFN  ranges:
>   <4 >[        0.000000]      DMA                          0  - >        16384
>   <4 >[        0.000000]      Normal            16384  - >        16384
>   <4 >[        0.000000]  Movable  zone  start  PFN  for  each  node
>   <4 >[        0.000000]  early_node_map[1]  active  PFN  ranges
>   <4 >[        0.000000]          0:                0  - >        16384
>   <7 >[        0.000000]  On  node  0  totalpages:  16384
>   <7 >[        0.000000]      DMA  zone:  128  pages  used  for  memmap
>   <7 >[        0.000000]      DMA  zone:  0  pages  reserved
>   <7 >[        0.000000]      DMA  zone:  16256  pages,  LIFO  batch:3
>   <7 >[        0.000000]      Normal  zone:  0  pages  used  for  memmap
>   <7 >[        0.000000]      Movable  zone:  0  pages  used  for  memmap
>   <4 >[        0.000000]  Built  1  zonelists  in  Zone  order.    Total  pages:  16256
>   <5 >[        0.000000]  Kernel  command  line:  console=ttUL0  root=/dev/xsysace2  rw

try the command line bootargs console=ttyUL0,boardrate root=/dev/xsysace2 rw 
you must make sure that you have the xsysace2 device, or you can take a test using ramdisk.i think it will run well

--=====003_Dragon125864718448_=====
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: base64

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBUcmFuc2l0aW9uYWwv
L0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgaHR0cC1lcXVpdj1Db250ZW50LVR5cGUgY29udGVu
dD0idGV4dC9odG1sOyBjaGFyc2V0PWdiMjMxMiI+DQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4w
MC4yOTAwLjMxNTciIG5hbWU9R0VORVJBVE9SPg0KPFNUWUxFPg0KPCEtLQ0KIC8qIEZvbnQgRGVm
aW5pdGlvbnMgKi8NCiBAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OsvOzOU7DQoJcGFub3NlLTE6
MiAxIDYgMCAzIDEgMSAxIDEgMTt9DQpAZm9udC1mYWNlDQoJe2ZvbnQtZmFtaWx5OlZlcmRhbmE7
DQoJcGFub3NlLTE6MiAxMSA2IDQgMyA1IDQgNCAyIDQ7fQ0KQGZvbnQtZmFjZQ0KCXtmb250LWZh
bWlseToiXEDLzszlIjsNCglwYW5vc2UtMToyIDEgNiAwIDMgMSAxIDEgMSAxO30NCiAvKiBTdHls
ZSBEZWZpbml0aW9ucyAqLw0KIHAuTXNvTm9ybWFsLCBsaS5Nc29Ob3JtYWwsIGRpdi5Nc29Ob3Jt
YWwNCgl7bWFyZ2luOjBjbTsNCgltYXJnaW4tYm90dG9tOi4wMDAxcHQ7DQoJdGV4dC1hbGlnbjpq
dXN0aWZ5Ow0KCXRleHQtanVzdGlmeTppbnRlci1pZGVvZ3JhcGg7DQoJZm9udC1zaXplOjEwLjVw
dDsNCglmb250LWZhbWlseToiVGltZXMgTmV3IFJvbWFuIjt9DQphOmxpbmssIHNwYW4uTXNvSHlw
ZXJsaW5rDQoJe2NvbG9yOmJsdWU7DQoJdGV4dC1kZWNvcmF0aW9uOnVuZGVybGluZTt9DQphOnZp
c2l0ZWQsIHNwYW4uTXNvSHlwZXJsaW5rRm9sbG93ZWQNCgl7Y29sb3I6cHVycGxlOw0KCXRleHQt
ZGVjb3JhdGlvbjp1bmRlcmxpbmU7fQ0Kc3Bhbi5FbWFpbFN0eWxlMTcNCgl7bXNvLXN0eWxlLXR5
cGU6cGVyc29uYWwtY29tcG9zZTsNCglmb250LWZhbWlseTpWZXJkYW5hOw0KCWNvbG9yOndpbmRv
d3RleHQ7DQoJZm9udC13ZWlnaHQ6bm9ybWFsOw0KCWZvbnQtc3R5bGU6bm9ybWFsOw0KCXRleHQt
ZGVjb3JhdGlvbjpub25lIG5vbmU7fQ0KIC8qIFBhZ2UgRGVmaW5pdGlvbnMgKi8NCiBAcGFnZSBT
ZWN0aW9uMQ0KCXtzaXplOjU5NS4zcHQgODQxLjlwdDsNCgltYXJnaW46NzIuMHB0IDkwLjBwdCA3
Mi4wcHQgOTAuMHB0Ow0KCWxheW91dC1ncmlkOjE1LjZwdDt9DQpkaXYuU2VjdGlvbjENCgl7cGFn
ZTpTZWN0aW9uMTt9DQotLT4NCjwvU1RZTEU+DQo8L0hFQUQ+DQo8Qk9EWT4NCjxESVY+PEZPTlQg
ZmFjZT1WZXJkYW5hIHNpemU9Mj48L0ZPTlQ+Jm5ic3A7PC9ESVY+DQo8RElWPjxGT05UIGZhY2U9
VmVyZGFuYSBzaXplPTI+DQo8RElWPk9uICZuYnNwOzEwLzE3LzA3LCAmbmJzcDthYXVlcjEgJm5i
c3A7ICZsdDthYXVlcjFAZ214LmF0ICZndDsgDQombmJzcDt3cm90ZTo8L0RJVj4NCjxESVY+Jmd0
OzwvRElWPg0KPERJVj4mZ3Q7PC9ESVY+DQo8RElWPiZndDsgJm5ic3A7R3JhbnQgJm5ic3A7TGlr
ZWx5LTIgJm5ic3A7d3JvdGU6PC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZndDs8L0RJVj4NCjxE
SVY+Jmd0OyAmbmJzcDsgJmd0OyAmbmJzcDtPbiAmbmJzcDsxMC8xNy8wNywgJm5ic3A7YWF1ZXIx
ICZuYnNwOyANCiZsdDthYXVlcjFAZ214LmF0ICZndDsgJm5ic3A7d3JvdGU6PC9ESVY+DQo8RElW
PiZndDsgJm5ic3A7ICZndDsgJmd0OyAmbmJzcDtOb3csICZuYnNwO0kgJm5ic3A7a25vdyAmbmJz
cDt0aGF0ICZuYnNwO3RoZSANCiZuYnNwO2tlcm5lbCAmbmJzcDtib290cyAmbmJzcDtidXQgJm5i
c3A7SSAmbmJzcDtkb24ndCAmbmJzcDtnZXQgJm5ic3A7YW4gDQombmJzcDtvdXRwdXQgJm5ic3A7
d2l0aCAmbmJzcDtteTwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwOyAmZ3Q7ICZndDsgJm5ic3A7WGls
aW54PC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZndDsgJmd0OyAmbmJzcDtVYXJ0TGl0ZSAmbmJz
cDttb2R1bGUuICZuYnNwO0FyZSAmbmJzcDt0aGVyZSANCiZuYnNwO3NvbWUgJm5ic3A7a2VybmVs
ICZuYnNwO21vZHVsZXMgJm5ic3A7d2hpY2ggJm5ic3A7bXVzdCAmbmJzcDtiZSANCiZuYnNwO2Fj
dGl2YXRlZD8/PC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZndDsgJmd0OyAmbmJzcDtCdHcuICZu
YnNwO0kgJm5ic3A7aGF2ZSAmbmJzcDt1c2VkICZuYnNwO3RoZSANCiZuYnNwO0xpbnV4LTIuNi12
aXJ0ZXggJm5ic3A7a2VybmVsICZuYnNwO2Zyb208L0RJVj4NCjxESVY+Jmd0OyAmbmJzcDsgJmd0
OyAmZ3Q7ICZuYnNwOzxBIA0KaHJlZj0iaHR0cDovL2dpdC5zZWNyZXRsYWIuY2EvZ2l0LyI+aHR0
cDovL2dpdC5zZWNyZXRsYWIuY2EvZ2l0LzwvQT4gJm5ic3A7YW5kIA0KJm5ic3A7YW5vdGhlciAm
bmJzcDtLZXJuZWwgJm5ic3A7KDIuNi4yMyAmbmJzcDtmcm9tICZuYnNwO2tlcm5lbC5vcmcpPC9E
SVY+DQo8RElWPiZndDsgJm5ic3A7ICZndDsgJmd0OyAmbmJzcDstPC9ESVY+DQo8RElWPiZndDsg
Jm5ic3A7ICZndDsgJmd0OyAmbmJzcDtib3RoICZuYnNwO3dpdGggJm5ic3A7dGhlICZuYnNwO3Nh
bWUgDQombmJzcDtyZXN1bHQuPC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZndDs8L0RJVj4NCjxE
SVY+Jmd0OyAmbmJzcDsgJmd0OyAmbmJzcDtQb3N0ICZuYnNwO3RoZSAmbmJzcDtvdXRwdXQgJm5i
c3A7b2YgJm5ic3A7X19sb2dfYnVmIA0KJm5ic3A7aGVyZSAmbmJzcDtwbGVhc2UuPC9ESVY+DQo8
RElWPiZndDsgJm5ic3A7ICZndDs8L0RJVj4NCjxESVY+Jmd0OyAmbmJzcDsgJmd0OzwvRElWPg0K
PERJVj4mZ3Q7PC9ESVY+DQo8RElWPiZndDsgJm5ic3A7SGVyZSAmbmJzcDtpcyAmbmJzcDtteSAm
bmJzcDtkdW1wICZuYnNwO29mICZuYnNwO3RoZSANCiZuYnNwO19fbG9nX2J1Zjo8L0RJVj4NCjxE
SVY+Jmd0OyAmbmJzcDs9PT09PT09PT09PT09PT09PT09PT09PC9ESVY+DQo8RElWPiZndDsgJm5i
c3A7ICZsdDs1ICZndDtbICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzAuMDAwMDAwXSAmbmJz
cDtMaW51eCANCiZuYnNwO3ZlcnNpb24gJm5ic3A7Mi42LjIzLXJjMjwvRElWPg0KPERJVj4mZ3Q7
ICZuYnNwOyhhYXVlckBzZXJ2aXR1cy5zdHVkZW50LmlhaWsudHVncmF6LmF0KSAmbmJzcDsoZ2Nj
ICZuYnNwO3ZlcnNpb24gDQombmJzcDs0LjAuMCAmbmJzcDsoREVOWCAmbmJzcDtFTERLICZuYnNw
OzQuMTwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwOzQuMDwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwOy4w
KSkgJm5ic3A7IzggJm5ic3A7V2VkICZuYnNwO09jdCAmbmJzcDsxNyAmbmJzcDsyMDowNToyOCAN
CiZuYnNwO0NFU1QgJm5ic3A7MjAwNzwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwOyAmbHQ7NiAmZ3Q7
WyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDswLjAwMDAwMF0gJm5ic3A7WGlsaW54IA0KJm5i
c3A7TUw0MDMgJm5ic3A7UmVmZXJlbmNlICZuYnNwO1N5c3RlbSAmbmJzcDsoVmlydGV4LTQgJm5i
c3A7RlgpPC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZsdDs3ICZndDtbICZuYnNwOyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOzAuMDAwMDAwXSAmbmJzcDtFbnRlcmluZyANCiZuYnNwO2FkZF9hY3RpdmVf
cmFuZ2UoMCwgJm5ic3A7MCwgJm5ic3A7MTYzODQpICZuYnNwOzAgJm5ic3A7ZW50cmllcyAmbmJz
cDtvZiANCiZuYnNwOzI1NjwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwO3VzZWQ8L0RJVj4NCjxESVY+
Jmd0OyAmbmJzcDsgJmx0OzQgJmd0O1sgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7MC4wMDAw
MDBdICZuYnNwO1pvbmUgDQombmJzcDtQRk4gJm5ic3A7cmFuZ2VzOjwvRElWPg0KPERJVj4mZ3Q7
ICZuYnNwOyAmbHQ7NCAmZ3Q7WyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDswLjAwMDAwMF0g
Jm5ic3A7ICZuYnNwOyANCiZuYnNwO0RNQSAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgDQombmJzcDsgJm5ic3A7ICZu
YnNwOzAgJm5ic3A7LSAmZ3Q7ICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzE2Mzg0PC9ESVY+
DQo8RElWPiZndDsgJm5ic3A7ICZsdDs0ICZndDtbICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OzAuMDAwMDAwXSAmbmJzcDsgJm5ic3A7IA0KJm5ic3A7Tm9ybWFsICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7MTYzODQgJm5ic3A7LSAmZ3Q7ICZuYnNwOyANCiZuYnNw
OyAmbmJzcDsgJm5ic3A7MTYzODQ8L0RJVj4NCjxESVY+Jmd0OyAmbmJzcDsgJmx0OzQgJmd0O1sg
Jm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7MC4wMDAwMDBdICZuYnNwO01vdmFibGUgDQombmJz
cDt6b25lICZuYnNwO3N0YXJ0ICZuYnNwO1BGTiAmbmJzcDtmb3IgJm5ic3A7ZWFjaCAmbmJzcDtu
b2RlPC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZsdDs0ICZndDtbICZuYnNwOyAmbmJzcDsgJm5i
c3A7ICZuYnNwOzAuMDAwMDAwXSANCiZuYnNwO2Vhcmx5X25vZGVfbWFwWzFdICZuYnNwO2FjdGl2
ZSAmbmJzcDtQRk4gJm5ic3A7cmFuZ2VzPC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZsdDs0ICZn
dDtbICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzAuMDAwMDAwXSAmbmJzcDsgJm5ic3A7IA0K
Jm5ic3A7ICZuYnNwOyAmbmJzcDswOiAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7
ICZuYnNwOyAmbmJzcDsgJm5ic3A7MCANCiZuYnNwOy0gJmd0OyAmbmJzcDsgJm5ic3A7ICZuYnNw
OyAmbmJzcDsxNjM4NDwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwOyAmbHQ7NyAmZ3Q7WyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDswLjAwMDAwMF0gJm5ic3A7T24gDQombmJzcDtub2RlICZuYnNw
OzAgJm5ic3A7dG90YWxwYWdlczogJm5ic3A7MTYzODQ8L0RJVj4NCjxESVY+Jmd0OyAmbmJzcDsg
Jmx0OzcgJmd0O1sgJm5ic3A7ICZuYnNwOyAmbmJzcDsgJm5ic3A7MC4wMDAwMDBdICZuYnNwOyAm
bmJzcDsgDQombmJzcDtETUEgJm5ic3A7em9uZTogJm5ic3A7MTI4ICZuYnNwO3BhZ2VzICZuYnNw
O3VzZWQgJm5ic3A7Zm9yIA0KJm5ic3A7bWVtbWFwPC9ESVY+DQo8RElWPiZndDsgJm5ic3A7ICZs
dDs3ICZndDtbICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNwOzAuMDAwMDAwXSAmbmJzcDsgJm5i
c3A7IA0KJm5ic3A7RE1BICZuYnNwO3pvbmU6ICZuYnNwOzAgJm5ic3A7cGFnZXMgJm5ic3A7cmVz
ZXJ2ZWQ8L0RJVj4NCjxESVY+Jmd0OyAmbmJzcDsgJmx0OzcgJmd0O1sgJm5ic3A7ICZuYnNwOyAm
bmJzcDsgJm5ic3A7MC4wMDAwMDBdICZuYnNwOyAmbmJzcDsgDQombmJzcDtETUEgJm5ic3A7em9u
ZTogJm5ic3A7MTYyNTYgJm5ic3A7cGFnZXMsICZuYnNwO0xJRk8gJm5ic3A7YmF0Y2g6MzwvRElW
Pg0KPERJVj4mZ3Q7ICZuYnNwOyAmbHQ7NyAmZ3Q7WyAmbmJzcDsgJm5ic3A7ICZuYnNwOyAmbmJz
cDswLjAwMDAwMF0gJm5ic3A7ICZuYnNwOyANCiZuYnNwO05vcm1hbCAmbmJzcDt6b25lOiAmbmJz
cDswICZuYnNwO3BhZ2VzICZuYnNwO3VzZWQgJm5ic3A7Zm9yIA0KJm5ic3A7bWVtbWFwPC9ESVY+
DQo8RElWPiZndDsgJm5ic3A7ICZsdDs3ICZndDtbICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OzAuMDAwMDAwXSAmbmJzcDsgJm5ic3A7IA0KJm5ic3A7TW92YWJsZSAmbmJzcDt6b25lOiAmbmJz
cDswICZuYnNwO3BhZ2VzICZuYnNwO3VzZWQgJm5ic3A7Zm9yIA0KJm5ic3A7bWVtbWFwPC9ESVY+
DQo8RElWPiZndDsgJm5ic3A7ICZsdDs0ICZndDtbICZuYnNwOyAmbmJzcDsgJm5ic3A7ICZuYnNw
OzAuMDAwMDAwXSAmbmJzcDtCdWlsdCANCiZuYnNwOzEgJm5ic3A7em9uZWxpc3RzICZuYnNwO2lu
ICZuYnNwO1pvbmUgJm5ic3A7b3JkZXIuICZuYnNwOyAmbmJzcDtUb3RhbCANCiZuYnNwO3BhZ2Vz
OiAmbmJzcDsxNjI1NjwvRElWPg0KPERJVj4mZ3Q7ICZuYnNwOyAmbHQ7NSAmZ3Q7WyAmbmJzcDsg
Jm5ic3A7ICZuYnNwOyAmbmJzcDswLjAwMDAwMF0gJm5ic3A7S2VybmVsIA0KJm5ic3A7Y29tbWFu
ZCAmbmJzcDtsaW5lOiAmbmJzcDtjb25zb2xlPXR0VUwwICZuYnNwO3Jvb3Q9L2Rldi94c3lzYWNl
MiANCiZuYnNwO3J3PC9ESVY+DQo8RElWPiZuYnNwOzwvRElWPg0KPERJVj50cnkgdGhlIGNvbW1h
bmQgbGluZSBib290YXJncyBjb25zb2xlPXR0eVVMMCxib2FyZHJhdGUgcm9vdD0vZGV2L3hzeXNh
Y2UyIA0KcncgPC9ESVY+DQo8RElWPnlvdSBtdXN0IG1ha2Ugc3VyZSB0aGF0IHlvdSBoYXZlIHRo
ZSB4c3lzYWNlMiBkZXZpY2UsIG9yIHlvdSBjYW4gdGFrZSBhIA0KdGVzdCB1c2luZyByYW1kaXNr
LmkgdGhpbmsgaXQgd2lsbCBydW4gd2VsbDwvRElWPg0KPERJVj4mbmJzcDs8L0RJVj4NCjxESVY+
Jm5ic3A7PC9ESVY+PC9GT05UPjwvRElWPjwvQk9EWT48L0hUTUw+DQo=

--=====003_Dragon125864718448_=====--
