Return-Path: <jxnuxdy@163.com>
Received: from m13-103.163.com (m13-103.163.com [220.181.13.103])
	by ozlabs.org (Postfix) with SMTP id 21BC4DDFCA
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Aug 2007 20:11:37 +1000 (EST)
Date: Mon, 27 Aug 2007 17:51:31 +0800 (CST)
From: jxnuxdy <jxnuxdy@163.com>
To: linuxppc-embedded@ozlabs.org
Message-ID: <479723497.472031188208291804.JavaMail.coremail@bj163app103.163.com>
Subject: how to debug the linux kernel with a BDI2000
MIME-Version: 1.0
Content-Type: multipart/Alternative;
	boundary="----=_Part_49996_1135804240.1188208291803"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_49996_1135804240.1188208291803
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit

My kernel hanged in when passed the parameters to it, and I dump nothing from the log_buf, so I guss it is crashed at the very beginning. however I didn't know how to setup the KDB to load the kernel with the BDI2000 ethernet? is there anyone has even loaded and debugged the kernel with the BDI2000 ethernet? if so pls show me how it goes?  ,Thanks- Denny
------=_Part_49996_1135804240.1188208291803
Content-Type: text/html; charset=gbk
Content-Transfer-Encoding: quoted-printable

<DIV>My kernel hanged in when passed the parameters to it, and I dump nothi=
ng from the log_buf, so I guss it is crashed at the very beginning.</DIV>
<DIV>&nbsp;</DIV>
<DIV>however I didn't know how to setup the KDB to load the kernel with the=
 BDI2000 ethernet? is there anyone has even loaded and debugged the kernel =
with the BDI2000 ethernet? if so pls show me how it goes?</DIV>
<DIV>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV>,Thanks</DIV>
<DIV>- Denny</DIV><br><!-- footer --><br><hr>
<a style=3D"font-size:14px;line-height:15px; color:#000; text-decoration:no=
ne" href=3D"http://event.mail.163.com/chanel/click.htm?from=3DNO_13&domain=
=3D163" target=3D"_blank"><span style=3D"text-decoration:underline; color:b=
lue">=C4=E3 =CD=E6 =B9=FD =B4=F3 =B8=BB =CE=CC =C2=F0=A3=BF=B3=AC =C8=CB =
=C6=F8 =C3=CE =BB=C3 =CE=F7 =D3=CE =B0=E6 =B4=F3 =B8=BB =CE=CC=A3=AC=B5=E3 =
=BB=F7 =C3=E2 =B7=D1 =CA=D4 =CD=E6 >></span> </a>
------=_Part_49996_1135804240.1188208291803--
