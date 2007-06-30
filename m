Return-Path: <silicom@163.com>
Received: from m13-48.163.com (m13-48.163.com [220.181.13.48])
	by ozlabs.org (Postfix) with SMTP id 5073BDDED1
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jun 2007 11:29:03 +1000 (EST)
Date: Sat, 30 Jun 2007 09:13:30 +0800 (CST)
From: silicom <silicom@163.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <4084073.1280021183166010150.JavaMail.coremail@bj163app48.163.com>
Subject: a question for ac97 driver interrupt
MIME-Version: 1.0
Content-Type: multipart/Alternative;
	boundary="----=_Part_130774_16636708.1183166010149"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_130774_16636708.1183166010149
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

 Hi
     I'm just adding interrupt function for my ac97 driver,but I don't know how to clear interrupt status in the interrupt handler,so it will cause nesting interrupt,can any one give me some advice about the structure of interrupt handle function?
  
------=_Part_130774_16636708.1183166010149
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<div>&nbsp;</div><div>Hi<br>&nbsp;&nbsp;&nbsp;&nbsp; I'm just adding interr=
upt function for my ac97 driver,but I don't know how to clear interrupt sta=
tus in the interrupt handler,so it will cause nesting interrupt,can any one=
 give me some advice about the structure of interrupt handle function?<br><=
/div><div>&nbsp;</div><div>&nbsp;</div><br><!-- footer --><br><hr>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/xyq.htm?from=3D163_NO1" target=
=3D"_blank"><span style=3D"text-decoration:underline; color:blue">150 =CD=
=F2 =C8=CB =CD=AC =CA=B1 =D4=DA =CD=E6 =B5=C4 =CD=F8 =D3=CE=A3=AC=C4=E3 =B2=
=BB =CA=D4 =CA=D4 =C2=F0 =A3=BF </span> </a>
------=_Part_130774_16636708.1183166010149--
