Return-Path: <jxnuxdy@163.com>
Received: from m13-18.163.com (m13-18.163.com [220.181.13.18])
	by ozlabs.org (Postfix) with SMTP id B010267A2E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 17:31:26 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44B74467.000148.09284@bj163app18.163.com>
Date: Fri, 14 Jul 2006 15:14:47 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: linuxppc-embedded@ozlabs.org
Subject: Failed to bring up the kernel on PPC440GP
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_banjchYtZhOKWRifXLcriMxFWLra"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_banjchYtZhOKWRifXLcriMxFWLra
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: 7bit

The system hangs, after it print "## Transferring control to Linux (at address 00000000) ..."
 
I dump the log buf, but still can't find the root cause, can anyone give some advice, thanks.
 
dump:
BDI>md 0x012c5c4
0012c5c4 : 20322e36 2e313420 08726f6f 73696f6e   2.6.14 .roosion
0012c5d4 : 20322e36 2e313420 08726f6f 74406c6f   2.6.14 .root@lo
0012c5e4 : 63616c68 6f73742e 6c6f6361 6c646f6d  calhost.localdom
0012c5f4 : 61696e29 20286763 63207665 5820454c  ain) (gcc veX EL
0012c604 : 444b2034 2e302034 2e302e30 5820454c  DK 4.0 4.0.0X EL
0012c614 : 444b2034 2e302034 2e302e30 2031b43a  DK 4.0 4.0.0 1.:
0012c624 : 35353a32 30200353 54203230 2031b43a  55:20 .ST 20 1.:
0012c634 : 35353a32 30200353 54203230 6e452063  55:20 .ST 20nE c
0012c644 : 6865636b 20696e20 6b65726e 6e452063  heck in kernnE c
0012c654 : 6865636b 20696e20 6b65726e 656c206d  heck in kernel m
0012c664 : 6f64652e 0a3c343e 504c4230 3a204245  ode..<4>PLB0: BE
0012c674 : 41523d30 78303030 30303030 32306563  AR=0x000000020ec
0012c684 : 30303030 36204143 523d2020 30783962  00006 ACR=  0x9b
0012c694 : 30303030 30302042 4553523d 20307830  000000 BESR= 0x0
0012c6a4 : 63303030 3030300a 3c343e50 4f42303a  c000000.<4>POB0:
0012c6b4 : 20424541 523d3078 30303030 30303030   BEAR=0x00000000
BDI>
 
Thanks in advance!
- Denny
 
--Boundary-=_banjchYtZhOKWRifXLcriMxFWLra
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV><SPAN >The system hangs, after it print "## Transferring control to =
Linux (at address 00000000) ..."</SPAN></DIV>
<DIV><SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN>I dump&nbsp;the log buf, but still can't find the root cause, =
can anyone give some advice, thanks.</SPAN></DIV>
<DIV><SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN>dump:</SPAN></DIV>
<DIV><SPAN>BDI&gt;md 0x012c5c4<BR>0012c5c4 : 20322e36 2e313420 08726f6f 7=
3696f6e&nbsp;&nbsp; 2.6.14 .roosion<BR>0012c5d4 : 20322e36 2e313420 08726=
f6f 74406c6f&nbsp;&nbsp; 2.6.14 <A href=3D"mailto:.root@lo">.root@lo</A><=
BR>0012c5e4 : 63616c68 6f73742e 6c6f6361 6c646f6d&nbsp; calhost.localdom<=
BR>0012c5f4 : 61696e29 20286763 63207665 5820454c&nbsp; ain) (gcc veX EL<=
BR>0012c604 : 444b2034 2e302034 2e302e30 5820454c&nbsp; DK 4.0 4.0.0X EL<=
BR>0012c614 : 444b2034 2e302034 2e302e30 2031b43a&nbsp; DK 4.0 4.0.0 1.:<=
BR>0012c624 : 35353a32 30200353 54203230 2031b43a&nbsp; 55:20 .ST 20 1.:<=
BR>0012c634 : 35353a32 30200353 54203230 6e452063&nbsp; 55:20 .ST 20nE c<=
BR>0012c644 : 6865636b 20696e20 6b65726e 6e452063&nbsp; heck in kernnE c<=
BR>0012c654 : 6865636b 20696e20 6b65726e 656c206d&nbsp; heck in kernel m<=
BR>0012c664 : 6f64652e 0a3c343e 504c4230 3a204245&nbsp; ode..&lt;4&gt;PLB=
0: BE<BR>0012c674 : 41523d30 78303030 30303030 32306563&nbsp; AR=3D0x0000=
00020ec<BR>0012c684 : 30303030 36204143 523d2020 30783962&nbsp; 00006 ACR=
=3D&nbsp; 0x9b<BR>0012c694 : 30303030 30302042 4553523d 20307830&nbsp; 00=
0000 BESR=3D 0x0<BR>0012c6a4 : 63303030 3030300a 3c343e50 4f42303a&nbsp; =
c000000.&lt;4&gt;POB0:<BR>0012c6b4 : 20424541 523d3078 30303030 30303030&=
nbsp;&nbsp; BEAR=3D0x00000000<BR>BDI&gt;</SPAN></DIV>
<DIV><SPAN></SPAN>&nbsp;</DIV>
<DIV><SPAN>Thanks in advance!</SPAN></DIV>
<DIV><SPAN>- Denny</SPAN></DIV>
<DIV><SPAN></SPAN>&nbsp;</DIV><br><!-- footer --><br><br><br><br><br><div=
 style=3D"border-bottom:1px solid #999"></div><br>

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


--Boundary-=_banjchYtZhOKWRifXLcriMxFWLra--
