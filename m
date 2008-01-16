Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id 416D8DDE0C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Jan 2008 07:02:36 +1100 (EST)
Date: Wed, 16 Jan 2008 21:02:31 +0100
Message-Id: <538215286@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: ml310 kernel2.6 booting problems
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thx for the answer

It's right, there is no /dev/console, but the MontaVista-Linux-kernel can =
fully boot with this rootFS, how comes=3F
Doesn't matter, I was going to make my own RootFS anyway, so can you give =
me an hint how I would
do this best=3F
I tried the Klingauf-Script (www.klingauf.com) with busybox, but I still h=
ave no console in my /dev/ and it doesn't work.
I tried out buildroot, but I was a little overstrained with the configurat=
ion and when I did "make" it aborted with an error message
after a long time of working
Then I tried ELDK. I read that I could use the Directory "<install-dir>/pp=
c=5F4xx/" as rootfs but when I go there and look inside=20
/dev I find only one entry:
prw------- 1 jogi jogi 0 2007-01-20 04:58 initctl
So this won't work, would it=3F

Which way would be the best for me to get an good RootFS easily=3F
If the answer would be buildroot can you give me a short summary which set=
tings are importent=3F
I read I can use my crosstool-Xcompiler, but I couldn't figure out how.=20

Greetings & Thx
Joachim

=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=

Erweitern Sie FreeMail zu einem noch leistungsst=E4rkeren E-Mail-Postfach!	=09
Mehr Infos unter http://produkte.web.de/club/=3Fmc=3D021131
