Return-Path: <silicom@163.com>
Received: from m13-129.163.com (m13-129.163.com [220.181.13.129])
	by ozlabs.org (Postfix) with SMTP id 3F924DDF91
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Jun 2007 22:38:40 +1000 (EST)
Date: Sat, 9 Jun 2007 20:21:30 +0800 (CST)
From: silicom <silicom@163.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <1316548361.5052161181391690811.JavaMail.coremail@bj163app129.163.com>
Subject: a question for linux framebuffer driver
MIME-Version: 1.0
Content-Type: multipart/Alternative;
	boundary="----=_Part_502267_1006930903.1181391690810"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_502267_1006930903.1181391690810
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

Hello,
Now I'm porting framebuffer driver for ml403 in linux 2.6.17.1, but I find after registering the driver using driver_register function in xilinxfb_int, the xilinxfb_drv_probe function has not been called, so framebuffer not registered yet, no devices founded(but I have connected the monitor). I want to know when will xilinxfb_drv_probe be called?
   
------=_Part_502267_1006930903.1181391690810
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>Hello,<br>Now I'm porting framebuffer driver for ml403 in linux 2.6.17=
1, but I find after registering the driver using driver_register function =
in xilinxfb_int, the xilinxfb_drv_probe function has not been called, so fr=
amebuffer not registered yet, no devices founded(but I have connected the m=
onitor). I want to know when will xilinxfb_drv_probe be called?<br></div><d=
iv>&nbsp;</div><div>&nbsp;</div><div>&nbsp;</div><br><!-- footer --><br><hr=
>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/xyq.htm?from=3D163_NO1" target=
=3D"_blank"><span style=3D"text-decoration:underline; color:blue">150 =CD=
=F2 =C8=CB =CD=AC =CA=B1 =D4=DA =CD=E6 =B5=C4 =CD=F8 =D3=CE=A3=AC=C4=E3 =B2=
=BB =CA=D4 =CA=D4 =C2=F0 =A3=BF </span> </a>
------=_Part_502267_1006930903.1181391690810--
