Return-Path: <mqy@263.net.cn>
Received: from image (unknown [221.232.31.114])
	by antispam-2 (Coremail:263(050316)) with SMTP id bnADASPK5EKRBB9y.1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Jul 2005 19:16:56 +0800 (CST)
From: "KylongMu" <mqy@263.net.cn>
To: <Linuxppc-embedded@ozlabs.org>
Date: Mon, 25 Jul 2005 19:16:50 +0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000D_01C5914D.6BB042B0"
Message-Id: <20050725111654.6A5A1C34A8@smtp.263.net>
Subject: mpc8540 SK board FEC not work!
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

------=_NextPart_000_000D_01C5914D.6BB042B0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hello, team
        I'm testing the 2.6.13-rc3 kernel on my board, all is work well
except
the FEC.
Board type:  PQ3SK REVB
Kernel       :  2.6.13-rc3
toolchain    : ELDK 3.1.1
PHY type  : Marvell 88E1111S

        Compile with "make mpc8540ads_defconfig", change with nothing.
download uImage file into my board and boot with it, all is ok ! But when
I config the eth0 , it can't work , same with eth1, both of them are
Giga-eth,
but eth2 is work well, and eth2 is a 10/100-eth.
        I checked the 8540ADS's hardware message , it's use 88E1011 PHY
not 88E1111 PHY . And I checked the kernel code " driver/net/gianfar_phy.c"
it takes 88E1011 and 88E1111 as same PHY , so I think this is not a hardware
problem, and my board work well with a 2.4.18 DEMO kernel.
        Here is the output message of  2.6.13-rc3 kernel:

PuffLinux:root$ifconfig eth0 192.168.1.77
eth0: PHY is Generic MII (ffffffff)

        If the PHY config is correct it will recognize my PHY ID, but here
is a
 wrong ID number ffffffff .

        Please help me solve this problem!

Thanks a lot!

                        KylongMu




------=_NextPart_000_000D_01C5914D.6BB042B0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<TITLE></TITLE>

<META content=3D"MSHTML 6.00.2900.2668" name=3DGENERATOR></HEAD>
<BODY><!-- Converted from text/plain format -->
<P>Hello, team<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I'm testing =
the=20
2.6.13-rc3 kernel on my board, all is work well except<BR>the =
FEC.<BR><FONT=20
color=3D#00ff00>Board type:&nbsp; PQ3SK=20
REVB<BR>Kernel&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; :&nbsp;=20
2.6.13-rc3<BR>toolchain&nbsp;&nbsp;&nbsp; : ELDK 3.1.1<BR>PHY type&nbsp; =
:=20
Marvell =
88E1111S<BR></FONT><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
Compile with "make mpc8540ads_defconfig", change with =
nothing.<BR>download=20
uImage file into my board and boot with it, all is ok ! But when<BR>I =
config the=20
eth0 , it can't work , same with eth1, both of them are Giga-eth,<BR>but =
eth2 is=20
work well, and eth2 is a=20
10/100-eth.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; I checked the=20
8540ADS's hardware message , it's use 88E1011 PHY<BR>not 88E1111 PHY . =
And I=20
checked the kernel code "<FONT color=3D#0000ff><EM>=20
driver/net/gianfar_phy.c</EM></FONT>"<BR>it takes 88E1011 and 88E1111 as =
same=20
PHY , so I think this is not a hardware<BR>problem,&nbsp;and my board =
work well=20
with a 2.4.18 DEMO kernel.<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Here is=20
the output message of&nbsp; 2.6.13-rc3 kernel:<BR><BR><FONT=20
color=3D#0000ff>PuffLinux:root$ifconfig eth0 192.168.1.77<BR>eth0: PHY =
is Generic=20
MII (ffffffff)<BR></FONT><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
If the=20
PHY config is correct it will recognize my PHY ID, but here is =
a<BR>&nbsp;wrong=20
ID number ffffffff .<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Please=20
help me solve this problem!<BR><BR>Thanks a=20
lot!<BR><BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
KylongMu<BR><BR></P></BODY></HTML>

------=_NextPart_000_000D_01C5914D.6BB042B0--
