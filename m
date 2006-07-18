Return-Path: <jxnuxdy@163.com>
Received: from m13-14.163.com (m13-14.163.com [220.181.13.14])
	by ozlabs.org (Postfix) with SMTP id F370167B83
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 18 Jul 2006 20:55:03 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44BCBA41.0000A9.06102@bj163app14.163.com>
Date: Tue, 18 Jul 2006 18:38:57 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: "" <linuxppc-embedded@ozlabs.org>
Subject: PPC440GP board hangs
References: <3DBBCC5C2604704D9351456CFE118AC10460F146@msilexch01.marvell.com>
In-Reply-To: <3DBBCC5C2604704D9351456CFE118AC10460F146@msilexch01.marvell.com>
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_MDavrfrQRHCxvpLSUcNzWjMEzDyr"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_MDavrfrQRHCxvpLSUcNzWjMEzDyr
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

Hi, 
   After success uncompress the kernel to ram, it hangs,
## Transferring control to Linux (at address 0000000)
 
   Does anyone encounter the symton on PPC440GP? I double checked my external UART clock and system clock both in hareware and software, they are all right.
 
the log buffer is as below:
BDI>md 0x01ed5c4 100
001ed5c4 : 0x20322e36    540159542   2.6
001ed5c8 : 0x2e313420    774976544  .14 
001ed5cc : 0x28726f6f    678588271  (roo
001ed5d0 : 0x73696f6e   1936289646  sion
001ed5d4 : 0x20322e36    540159542   2.6
001ed5d8 : 0x2e313420    774976544  .14 
001ed5dc : 0x28726f6f    678588271  (roo
001ed5e0 : 0x6c646f7d   1818521469  ldo}
001ed5e4 : 0x61696e29   1634299433  ain)
001ed5e8 : 0x20286763    539518819   (gc
001ed5ec : 0x63207665   1663071845  c ve
001ed5f0 : 0x6c646f7d   1818521469  ldo}
001ed5f4 : 0x61696e29   1634299433  ain)
001ed5f8 : 0x20286763    539518819   (gc
001ed5fc : 0x63207665   1663071845  c ve
001ed600 : 0x5820054c   1478493516  X .L
001ed604 : 0x444b2034   1145774132  DK 4
001ed608 : 0x2f302034    791683124  /0 4
001ed60c : 0x2e302e30    774909488  .0.0
001ed610 : 0x5820054c   1478493516  X .L
001ed614 : 0x444b2034   1145774132  DK 4
001ed618 : 0x2f302034    791683124  /0 4
001ed61c : 0x2e302e30    774909488  .0.0
001ed620 : 0x2031383a    540096570   18:
001ed624 : 0x31383a33    825768499  18:3
001ed628 : 0x34204353    874529619  4 CS
001ed62c : 0x54203630   1411397168  T 60
001ed630 : 0x2031383a    540096570   18:
001ed634 : 0x31383a33    825768499  18:3
001ed638 : 0x34204353    874529619  4 CS
001ed63c : 0x54203630   1411397168  T 60
001ed640 : 0x6e652063   1852121187  ne c
001ed644 : 0x6865636b   1751475051  heck
001ed648 : 0x20696e20    543780384   in 
001ed64c : 0x6b65726e   1801810542  kern
001ed650 : 0x6e652063   1852121187  ne c
001ed654 : 0x6865636b   1751475051  heck
001ed658 : 0x20696e20    543780384   in 
001ed65c : 0x6b65726e   1801810542  kern
001ed660 : 0x656c206d   1701585005  el m
001ed664 : 0x6f64652e   1868850478  ode.
001ed668 : 0x0a3c343e    171717694  .<4>
001ed66c : 0x504c4230   1347174960  PLB0
001ed670 : 0x3a204245    975192645  : BE
001ed674 : 0x41523d30   1095908656  AR=0
001ed678 : 0x78303030   2016423984  x000
001ed67c : 0x30303030    808464432  0000
001ed680 : 0x32306563    842032483  20ec
001ed684 : 0x30303030    808464432  0000
001ed688 : 0x36204143    908083523  6 AC
001ed68c : 0x523d2020   1379737632  R=  
001ed690 : 0x30783962    813185378  0x9b
001ed694 : 0x30303030    808464432  0000
001ed698 : 0x30302042    808460354  00 B
001ed69c : 0x4553523d   1163088445  ESR=
001ed6a0 : 0x20307830    540047408   0x0
001ed6a4 : 0x63303030   1664102448  c000
001ed6a8 : 0x3030300a    808464394  000.
001ed6ac : 0x3c343e50   1010056784  <4>P
001ed6b0 : 0x4f42303a   1329737786  OB0:
001ed6b4 : 0x20424541    541214017   BEA
001ed6b8 : 0x523d3078   1379741816  R=0x
001ed6bc : 0x30303030    808464432  0000
001ed6c0 : 0x30303030    808464432  0000
001ed6c4 : 0x30303030    808464432  0000
001ed6c8 : 0x30303030    808464432  0000
001ed6cc : 0x20424553    541214035   BES
001ed6d0 : 0x52303d30   1378893104  R0=0
001ed6d4 : 0x78303030   2016423984  x000
001ed6d8 : 0x30303030    808464432  0000
001ed6dc : 0x30204245    807420485  0 BE
001ed6e0 : 0x5352313d   1397895485  SR1=
001ed6e4 : 0x30783030    813183024  0x00
001ed6e8 : 0x30303030    808464432  0000
001ed6ec : 0x30300a3c    808454716  00.<
001ed6f0 : 0x343e4f50    876498768  4>OP
001ed6f4 : 0x42303a20   1110456864  B0: 
001ed6f8 : 0x42454152   1111834962  BEAR
001ed6fc : 0x3d307830   1026586672  =0x0
001ed700 : 0x30303030    808464432  0000
001ed704 : 0x30303030    808464432  0000
001ed708 : 0x30303030    808464432  0000
001ed70c : 0x30303020    808464416  000 
001ed710 : 0x42535441   1112757313  BSTA
001ed714 : 0x543d3078   1413296248  T=0x
001ed718 : 0x30303030    808464432  0000
001ed71c : 0x30303030    808464432  0000
001ed720 : 0x0a3c343e    171717694  .<4>
001ed724 : 0x4f6f7073   1332703347  Oops
001ed728 : 0x3a206d61    975203681  : ma
001ed72c : 0x6368696e   1667787118  chin
001ed730 : 0x65206368   1696621416  e ch
001ed734 : 0x65636b2c   1701014316  eck,
001ed738 : 0x20736967    544434535   sig
001ed73c : 0x3a203720    975189792  : 7 
001ed740 : 0x5b23315d   1529033053  [#1]
001ed744 : 0x0a3c343e    171717694  .<4>
001ed748 : 0x4e49503a   1313427514  NIP:
001ed74c : 0x20433030    541274160   C00
001ed750 : 0x30443946    809777478  0D9F
BDI>
 
    Any point on this is very appreciated!
    - Denny
 
--Boundary-=_MDavrfrQRHCxvpLSUcNzWjMEzDyr
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi, </DIV>
<DIV>&nbsp;&nbsp; After success uncompress the kernel to ram, it hangs,</=
DIV>
<DIV>## Transferring control to Linux (at address 0000000)</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp; Does anyone encounter the symton on PPC440GP? I double =
checked my external UART clock and system clock both in hareware and soft=
ware, they are all right.</DIV>
<DIV>&nbsp;</DIV>
<DIV>the log buffer is as below:</DIV>
<DIV>BDI&gt;md 0x01ed5c4 100<BR>001ed5c4 : 0x20322e36&nbsp;&nbsp;&nbsp; 5=
40159542&nbsp;&nbsp; 2.6<BR>001ed5c8 : 0x2e313420&nbsp;&nbsp;&nbsp; 77497=
6544&nbsp; .14 <BR>001ed5cc : 0x28726f6f&nbsp;&nbsp;&nbsp; 678588271&nbsp=
; (roo<BR>001ed5d0 : 0x73696f6e&nbsp;&nbsp; 1936289646&nbsp; sion<BR>001e=
d5d4 : 0x20322e36&nbsp;&nbsp;&nbsp; 540159542&nbsp;&nbsp; 2.6<BR>001ed5d8=
 : 0x2e313420&nbsp;&nbsp;&nbsp; 774976544&nbsp; .14 <BR>001ed5dc : 0x2872=
6f6f&nbsp;&nbsp;&nbsp; 678588271&nbsp; (roo<BR>001ed5e0 : 0x6c646f7d&nbsp=
;&nbsp; 1818521469&nbsp; ldo}<BR>001ed5e4 : 0x61696e29&nbsp;&nbsp; 163429=
9433&nbsp; ain)<BR>001ed5e8 : 0x20286763&nbsp;&nbsp;&nbsp; 539518819&nbsp=
;&nbsp; (gc<BR>001ed5ec : 0x63207665&nbsp;&nbsp; 1663071845&nbsp; c ve<BR=
>001ed5f0 : 0x6c646f7d&nbsp;&nbsp; 1818521469&nbsp; ldo}<BR>001ed5f4 : 0x=
61696e29&nbsp;&nbsp; 1634299433&nbsp; ain)<BR>001ed5f8 : 0x20286763&nbsp;=
&nbsp;&nbsp; 539518819&nbsp;&nbsp; (gc<BR>001ed5fc : 0x63207665&nbsp;&nbs=
p; 1663071845&nbsp; c ve<BR>001ed600 : 0x5820054c&nbsp;&nbsp; 1478493516&=
nbsp; X .L<BR>001ed604 : 0x444b2034&nbsp;&nbsp; 1145774132&nbsp; DK 4<BR>=
001ed608 : 0x2f302034&nbsp;&nbsp;&nbsp; 791683124&nbsp; /0 4<BR>001ed60c =
: 0x2e302e30&nbsp;&nbsp;&nbsp; 774909488&nbsp; .0.0<BR>001ed610 : 0x58200=
54c&nbsp;&nbsp; 1478493516&nbsp; X .L<BR>001ed614 : 0x444b2034&nbsp;&nbsp=
; 1145774132&nbsp; DK 4<BR>001ed618 : 0x2f302034&nbsp;&nbsp;&nbsp; 791683=
124&nbsp; /0 4<BR>001ed61c : 0x2e302e30&nbsp;&nbsp;&nbsp; 774909488&nbsp;=
 .0.0<BR>001ed620 : 0x2031383a&nbsp;&nbsp;&nbsp; 540096570&nbsp;&nbsp; 18=
:<BR>001ed624 : 0x31383a33&nbsp;&nbsp;&nbsp; 825768499&nbsp; 18:3<BR>001e=
d628 : 0x34204353&nbsp;&nbsp;&nbsp; 874529619&nbsp; 4 CS<BR>001ed62c : 0x=
54203630&nbsp;&nbsp; 1411397168&nbsp; T 60<BR>001ed630 : 0x2031383a&nbsp;=
&nbsp;&nbsp; 540096570&nbsp;&nbsp; 18:<BR>001ed634 : 0x31383a33&nbsp;&nbs=
p;&nbsp; 825768499&nbsp; 18:3<BR>001ed638 : 0x34204353&nbsp;&nbsp;&nbsp; =
874529619&nbsp; 4 CS<BR>001ed63c : 0x54203630&nbsp;&nbsp; 1411397168&nbsp=
; T 60<BR>001ed640 : 0x6e652063&nbsp;&nbsp; 1852121187&nbsp; ne c<BR>001e=
d644 : 0x6865636b&nbsp;&nbsp; 1751475051&nbsp; heck<BR>001ed648 : 0x20696=
e20&nbsp;&nbsp;&nbsp; 543780384&nbsp;&nbsp; in <BR>001ed64c : 0x6b65726e&=
nbsp;&nbsp; 1801810542&nbsp; kern<BR>001ed650 : 0x6e652063&nbsp;&nbsp; 18=
52121187&nbsp; ne c<BR>001ed654 : 0x6865636b&nbsp;&nbsp; 1751475051&nbsp;=
 heck<BR>001ed658 : 0x20696e20&nbsp;&nbsp;&nbsp; 543780384&nbsp;&nbsp; in=
 <BR>001ed65c : 0x6b65726e&nbsp;&nbsp; 1801810542&nbsp; kern<BR>001ed660 =
: 0x656c206d&nbsp;&nbsp; 1701585005&nbsp; el m<BR>001ed664 : 0x6f64652e&n=
bsp;&nbsp; 1868850478&nbsp; ode.<BR>001ed668 : 0x0a3c343e&nbsp;&nbsp;&nbs=
p; 171717694&nbsp; .&lt;4&gt;<BR>001ed66c : 0x504c4230&nbsp;&nbsp; 134717=
4960&nbsp; PLB0<BR>001ed670 : 0x3a204245&nbsp;&nbsp;&nbsp; 975192645&nbsp=
; : BE<BR>001ed674 : 0x41523d30&nbsp;&nbsp; 1095908656&nbsp; AR=3D0<BR>00=
1ed678 : 0x78303030&nbsp;&nbsp; 2016423984&nbsp; x000<BR>001ed67c : 0x303=
03030&nbsp;&nbsp;&nbsp; 808464432&nbsp; 0000<BR>001ed680 : 0x32306563&nbs=
p;&nbsp;&nbsp; 842032483&nbsp; 20ec<BR>001ed684 : 0x30303030&nbsp;&nbsp;&=
nbsp; 808464432&nbsp; 0000<BR>001ed688 : 0x36204143&nbsp;&nbsp;&nbsp; 908=
083523&nbsp; 6 AC<BR>001ed68c : 0x523d2020&nbsp;&nbsp; 1379737632&nbsp; R=
=3D&nbsp; <BR>001ed690 : 0x30783962&nbsp;&nbsp;&nbsp; 813185378&nbsp; 0x9=
b<BR>001ed694 : 0x30303030&nbsp;&nbsp;&nbsp; 808464432&nbsp; 0000<BR>001e=
d698 : 0x30302042&nbsp;&nbsp;&nbsp; 808460354&nbsp; 00 B<BR>001ed69c : 0x=
4553523d&nbsp;&nbsp; 1163088445&nbsp; ESR=3D<BR>001ed6a0 : 0x20307830&nbs=
p;&nbsp;&nbsp; 540047408&nbsp;&nbsp; 0x0<BR>001ed6a4 : 0x63303030&nbsp;&n=
bsp; 1664102448&nbsp; c000<BR>001ed6a8 : 0x3030300a&nbsp;&nbsp;&nbsp; 808=
464394&nbsp; 000.<BR>001ed6ac : 0x3c343e50&nbsp;&nbsp; 1010056784&nbsp; &=
lt;4&gt;P<BR>001ed6b0 : 0x4f42303a&nbsp;&nbsp; 1329737786&nbsp; OB0:<BR>0=
01ed6b4 : 0x20424541&nbsp;&nbsp;&nbsp; 541214017&nbsp;&nbsp; BEA<BR>001ed=
6b8 : 0x523d3078&nbsp;&nbsp; 1379741816&nbsp; R=3D0x<BR>001ed6bc : 0x3030=
3030&nbsp;&nbsp;&nbsp; 808464432&nbsp; 0000<BR>001ed6c0 : 0x30303030&nbsp=
;&nbsp;&nbsp; 808464432&nbsp; 0000<BR>001ed6c4 : 0x30303030&nbsp;&nbsp;&n=
bsp; 808464432&nbsp; 0000<BR>001ed6c8 : 0x30303030&nbsp;&nbsp;&nbsp; 8084=
64432&nbsp; 0000<BR>001ed6cc : 0x20424553&nbsp;&nbsp;&nbsp; 541214035&nbs=
p;&nbsp; BES<BR>001ed6d0 : 0x52303d30&nbsp;&nbsp; 1378893104&nbsp; R0=3D0=
<BR>001ed6d4 : 0x78303030&nbsp;&nbsp; 2016423984&nbsp; x000<BR>001ed6d8 :=
 0x30303030&nbsp;&nbsp;&nbsp; 808464432&nbsp; 0000<BR>001ed6dc : 0x302042=
45&nbsp;&nbsp;&nbsp; 807420485&nbsp; 0 BE<BR>001ed6e0 : 0x5352313d&nbsp;&=
nbsp; 1397895485&nbsp; SR1=3D<BR>001ed6e4 : 0x30783030&nbsp;&nbsp;&nbsp; =
813183024&nbsp; 0x00<BR>001ed6e8 : 0x30303030&nbsp;&nbsp;&nbsp; 808464432=
&nbsp; 0000<BR>001ed6ec : 0x30300a3c&nbsp;&nbsp;&nbsp; 808454716&nbsp; 00=
=2E&lt;<BR>001ed6f0 : 0x343e4f50&nbsp;&nbsp;&nbsp; 876498768&nbsp; 4&gt;O=
P<BR>001ed6f4 : 0x42303a20&nbsp;&nbsp; 1110456864&nbsp; B0: <BR>001ed6f8 =
: 0x42454152&nbsp;&nbsp; 1111834962&nbsp; BEAR<BR>001ed6fc : 0x3d307830&n=
bsp;&nbsp; 1026586672&nbsp; =3D0x0<BR>001ed700 : 0x30303030&nbsp;&nbsp;&n=
bsp; 808464432&nbsp; 0000<BR>001ed704 : 0x30303030&nbsp;&nbsp;&nbsp; 8084=
64432&nbsp; 0000<BR>001ed708 : 0x30303030&nbsp;&nbsp;&nbsp; 808464432&nbs=
p; 0000<BR>001ed70c : 0x30303020&nbsp;&nbsp;&nbsp; 808464416&nbsp; 000 <B=
R>001ed710 : 0x42535441&nbsp;&nbsp; 1112757313&nbsp; BSTA<BR>001ed714 : 0=
x543d3078&nbsp;&nbsp; 1413296248&nbsp; T=3D0x<BR>001ed718 : 0x30303030&nb=
sp;&nbsp;&nbsp; 808464432&nbsp; 0000<BR>001ed71c : 0x30303030&nbsp;&nbsp;=
&nbsp; 808464432&nbsp; 0000<BR>001ed720 : 0x0a3c343e&nbsp;&nbsp;&nbsp; 17=
1717694&nbsp; .&lt;4&gt;<BR>001ed724 : 0x4f6f7073&nbsp;&nbsp; 1332703347&=
nbsp; Oops<BR>001ed728 : 0x3a206d61&nbsp;&nbsp;&nbsp; 975203681&nbsp; : m=
a<BR>001ed72c : 0x6368696e&nbsp;&nbsp; 1667787118&nbsp; chin<BR>001ed730 =
: 0x65206368&nbsp;&nbsp; 1696621416&nbsp; e ch<BR>001ed734 : 0x65636b2c&n=
bsp;&nbsp; 1701014316&nbsp; eck,<BR>001ed738 : 0x20736967&nbsp;&nbsp;&nbs=
p; 544434535&nbsp;&nbsp; sig<BR>001ed73c : 0x3a203720&nbsp;&nbsp;&nbsp; 9=
75189792&nbsp; : 7 <BR>001ed740 : 0x5b23315d&nbsp;&nbsp; 1529033053&nbsp;=
 [#1]<BR>001ed744 : 0x0a3c343e&nbsp;&nbsp;&nbsp; 171717694&nbsp; .&lt;4&g=
t;<BR>001ed748 : 0x4e49503a&nbsp;&nbsp; 1313427514&nbsp; NIP:<BR>001ed74c=
 : 0x20433030&nbsp;&nbsp;&nbsp; 541274160&nbsp;&nbsp; C00<BR>001ed750 : 0=
x30443946&nbsp;&nbsp;&nbsp; 809777478&nbsp; 0D9F<BR>BDI&gt;</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;&nbsp;&nbsp; Any point on this is very appreciated!</DIV>
<DIV>&nbsp;&nbsp;&nbsp; - Denny</DIV>
<DIV>&nbsp;</DIV><SPAN ></SPAN><br><!-- footer --><br><br><br><br><br><di=
v style=3D"border-bottom:1px solid #999"></div><br>

=09<font color=3D"black" style=3D"font-size:14.8px">=CF=EB =D2=AA =CC=E5 =
=D1=E9 =D2=BB =CF=C2 =B3=AC =B4=F3 =B3=AC =BF=EC =B5=C4 =C3=E2 =B7=D1 =D3=
=CA =CF=E4 =C2=F0 =A3=BF</font>
=09<br>
=09 <a href=3D"http://www.126.com/" target=3D"_blank" style=3D"font-size:=
13px;line-height:160%;color:blue">=CD=F8 =D2=D7 3G =C3=E2 =B7=D1 =D3=CA =A3=
=AC=C7=C0 =D7=A2 =D4=D9 =B5=C3 280 =D5=D7 =B4=F3 =C8=DD =C1=BF =CD=F8 =C5=
=CC =A3=AC=BF=EC =C0=B4 =CC=E5 =D1=E9 =D3=CA =CF=E4 =BC=AB =CB=D9 =D6=AE =
=C2=C3
</a>


--Boundary-=_MDavrfrQRHCxvpLSUcNzWjMEzDyr--
