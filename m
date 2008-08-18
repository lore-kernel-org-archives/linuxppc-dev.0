Return-Path: <fabien.oriede@yahoo.fr>
Received: from web27407.mail.ukl.yahoo.com (web27407.mail.ukl.yahoo.com
	[217.146.177.183]) by ozlabs.org (Postfix) with SMTP id 09F31DDE2A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 18 Aug 2008 19:11:33 +1000 (EST)
Date: Mon, 18 Aug 2008 09:11:31 +0000 (GMT)
From: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: Kernel panic : No Init Found
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: multipart/alternative; boundary="0-1204230445-1219050691=:65788"
Message-ID: <642357.65788.qm@web27407.mail.ukl.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1204230445-1219050691=:65788
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,=0AI have downloaded the SELF pRamdisk image from the DENX website a=
nd I placed it in FLASH at 0xFFC00000. The init file is in /sbin/init. When=
 I try to boot Linux with "bootm ffa00000 ffc00000", Linux mounts the initr=
d image and next,=C2=A0it=C2=A0shows the message "No Init Found" even if I =
have "init=3D/sbin/init" in the kernel command line.=0ADoes I need to activ=
ate MTD options in the kernel to use an initrd image ?=0AThanks,=0AFabien.=
=0A=0A=0A      ____________________________________________________________=
_________________ =0AEnvoyez avec Yahoo! Mail. Une boite mail plus intellig=
ente http://mail.yahoo.fr
--0-1204230445-1219050691=:65788
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:arial, helvetica, sans-serif;font-size:1=
0pt"><DIV>Hi all,</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>I have downloaded the SE=
LF pRamdisk image from the DENX website and I placed it in FLASH at 0xFFC00=
000. The init file is in /sbin/init. When I try to boot Linux with "bootm f=
fa00000 ffc00000", Linux mounts the initrd image and next,&nbsp;it&nbsp;sho=
ws the message "No Init Found" even if I have "init=3D/sbin/init" in the ke=
rnel command line.</DIV>=0A<DIV>&nbsp;</DIV>=0A<DIV>Does I need to activate=
 MTD options in the kernel to use an initrd image ?</DIV>=0A<DIV>&nbsp;</DI=
V>=0A<DIV>Thanks,</DIV>=0A<DIV>Fabien.</DIV></div><br>=0A=0A=0A      <hr si=
ze=3D"1"> =0AEnvoy=C3=A9 avec <a href=3D"http://us.rd.yahoo.com/mailuk/tagl=
ines/isp/control/*http://us.rd.yahoo.com/evt=3D52423/*http://fr.docs.yahoo.=
com/mail/overview/index.html">Yahoo! Mail</a>.<br>Une boite mail plus intel=
ligente. </a></body></html>
--0-1204230445-1219050691=:65788--
