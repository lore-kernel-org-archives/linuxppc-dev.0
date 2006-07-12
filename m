Return-Path: <jxnuxdy@163.com>
Received: from m13-79.163.com (m13-79.163.com [220.181.13.79])
	by ozlabs.org (Postfix) with SMTP id E505167BAC
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Jul 2006 19:22:57 +1000 (EST)
MIME-Version: 1.0
Message-ID: <44B4BADE.0000FE.02838@bj163app79.163.com>
Date: Wed, 12 Jul 2006 17:03:26 +0800 (CST)
From: "Denny" <jxnuxdy@163.com>
To: linuxppc-embedded@ozlabs.org
Subject: Fw: Failed to setup RMII ethernet on PPC4
 40GP
Content-Type: Multipart/Alternative;
	boundary="Boundary-=_HdDINcyAsHJAorRtxSpRfpAKYcoq"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Boundary-=_HdDINcyAsHJAorRtxSpRfpAKYcoq
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi,
=20
  I failed to setup RMII ethernet interface of the UBoot on my custom boa=
rd -- PPC440GP,
It always tell me "time out", and the wrong ethernet speed, why?
=20
  I defined the MII and RMII macro in my config header, and still does no=
t work.
  (Anyway, I success to setup a MII ethernet interface on the PPC405GP,sh=
ould I change the RMII interface to MII on the hardware level?)
=20
logs:
u-boot =3D> tftp 0x100000 tmp.img
miiphy_register: non unique device name 'ppc_4xx_eth0'
Waiting for PHY auto negotiation to complete..... TIMEOUT !
 done
ENET Speed is 10 Mbps - HALF duplex connection
TFTP from server 192.168.65.235; our IP address is 192.168.65.239
Filename 'tmp.img'.
Load address: 0x100000
Loading: T T
=20
Thanks & Regards!
- Denny
=20







=CF=EB =D2=AA =CC=E5 =D1=E9 =D2=BB =CF=C2 =B3=AC =B4=F3 =B3=AC =BF=EC =B5=
=C4 =C3=E2 =B7=D1 =D3=CA =CF=E4 =C2=F0 =A3=BF=20
=CD=F8 =D2=D7 3G =C3=E2 =B7=D1 =D3=CA =A3=AC=C7=C0 =D7=A2 =D4=D9 =B5=C3 2=
80 =D5=D7 =B4=F3 =C8=DD =C1=BF =CD=F8 =C5=CC =A3=AC=BF=EC =C0=B4 =CC=E5 =D1=
=E9 =D3=CA =CF=E4 =BC=AB =CB=D9 =D6=AE =C2=C3=20
--Boundary-=_HdDINcyAsHJAorRtxSpRfpAKYcoq
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<DIV>Hi,</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; I failed to setup RMII ethernet interface of the UBoot on my =
custom board -- PPC440GP,</DIV>
<DIV>It always tell me&nbsp;"time out", and the wrong ethernet speed, why=
?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp; I defined the MII and RMII macro in my config header, and sti=
ll does&nbsp;not work.</DIV>
<DIV>&nbsp;&nbsp;(Anyway,&nbsp;I success to setup a MII ethernet interfac=
e on the PPC405GP,should I change the RMII interface to MII on the hardwa=
re level?)</DIV>
<DIV>&nbsp;</DIV>
<DIV>logs:</DIV>
<DIV>u-boot =3D&gt; tftp 0x100000 tmp.img<BR>miiphy_register: non unique =
device name 'ppc_4xx_eth0'<BR>Waiting for PHY auto negotiation to complet=
e..... TIMEOUT !<BR>&nbsp;done<BR>ENET Speed is 10 Mbps - HALF duplex con=
nection<BR>TFTP from server 192.168.65.235; our IP address is 192.168.65.=
239<BR>Filename 'tmp.img'.<BR>Load address: 0x100000<BR>Loading: T T</DIV=
>
<DIV>&nbsp;</DIV>
<DIV>Thanks &amp; Regards!</DIV>
<DIV>- Denny</DIV>
<DIV>&nbsp;</DIV><SPAN></SPAN><BR><!-- footer --><BR><BR><BR><BR><BR>
<DIV style=3D"BORDER-BOTTOM: #999 1px solid"></DIV><BR><FONT style=3D"FON=
T-SIZE: 14px" color=3Dblack>=CF=EB =D2=AA =CC=E5 =D1=E9 =D2=BB =CF=C2 =B3=
=AC =B4=F3 =B3=AC =BF=EC =B5=C4 =C3=E2 =B7=D1 =D3=CA =CF=E4 =C2=F0 =A3=BF=
</FONT> <BR><A style=3D"FONT-SIZE: 13px; COLOR: blue; LINE-HEIGHT: 160%" =
href=3D"http://www.126.com/" target=3D_blank>=CD=F8 =D2=D7 3G =C3=E2 =B7=D1=
 =D3=CA =A3=AC=C7=C0 =D7=A2 =D4=D9 =B5=C3 280 =D5=D7 =B4=F3 =C8=DD =C1=BF=
 =CD=F8 =C5=CC =A3=AC=BF=EC =C0=B4 =CC=E5 =D1=E9 =D3=CA =CF=E4 =BC=AB =CB=
=D9 =D6=AE =C2=C3 </A><br><!-- footer --><br><br><br><br><br><div style=3D=
"border-bottom:1px solid #999"></div><br>

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


--Boundary-=_HdDINcyAsHJAorRtxSpRfpAKYcoq--
