Return-Path: <isaac.gomez.morales@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id CD1B6B7088
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 11 Sep 2009 01:01:58 +1000 (EST)
Received: from mail-ew0-f227.google.com (mail-ew0-f227.google.com
	[209.85.219.227]) by ozlabs.org (Postfix) with ESMTP id A9AEFDDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Sep 2009 01:01:56 +1000 (EST)
Received: by ewy27 with SMTP id 27so211797ewy.40
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Sep 2009 08:01:54 -0700 (PDT)
MIME-Version: 1.0
Date: Thu, 10 Sep 2009 17:01:53 +0200
Message-ID: <38a5a2d10909100801x11049cddi1799c0ed6ee44410@mail.gmail.com>
Subject: Debian on MPC8572DS
From: Isaac Gomez Morales <isaac.gomez.morales@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=000e0cdfc602e4562a04733a7aab
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--000e0cdfc602e4562a04733a7aab
Content-Type: text/plain; charset=ISO-8859-1

Hello,

I'm trying to get a Linux distro such as Debian in the following system

System:
mpc8572ds HW
u-boot programmed on flash memory
vanillia linux installed on sata disk

Restrictions:
i have not apt-get resident on system


I have tried the following ways with no succeful results:

I tried to run deboostrap with chroot on mpc8572ds

I tried to run deboostrap on another machine, downloading the correct
packages for ppc enviroment and copiny those packages in a new ext2
partition of my 8572 hw. After that i executed "chroot /mnt/newpartition
/bin/bash" and it returned "Illegal instruction". At this point i can't
follow the installation and if i force to startup the machine with that rf
system, it returns a "kernel panic" with error to handling the signal 4 of
init process.

I tried to get start the machine with a debain livecd installation. I
created an uImage and initrd from cdrom's vmlinux and initrd.gz with the
uboot-mkimage tool, then i booted it from u-boot but the kernel didn't
start.

I tried to start a preinstalled Debian for a simillar architecture, in
cocnret from a mpc8561 ppc's Debian. I put its hhdd with the Debian rfs on
my machine and start it with my uImage and dtb files. The results was the
same "kernel panic" and signal 4 error.



I accept all ideas.

Thanks you all and sorry for my english

--000e0cdfc602e4562a04733a7aab
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello,<br><br>I&#39;m trying to get a Linux distro such as Debian in the fo=
llowing system<br><br>System:<br><div style=3D"margin-left: 40px;">mpc8572d=
s HW<br>u-boot programmed on flash memory<br>vanillia linux installed on sa=
ta disk<br>
<br></div>Restrictions:<br><div style=3D"margin-left: 40px;">i have not apt=
-get resident on system<br></div><br><br>I have tried the following ways wi=
th no succeful results:<br><br><div style=3D"margin-left: 40px;">I tried to=
 run deboostrap with chroot on mpc8572ds<br>
<br>I tried to run deboostrap on another machine, downloading the correct p=
ackages for ppc enviroment and copiny those packages in a new ext2 partitio=
n of my 8572 hw. After that i executed &quot;chroot /mnt/newpartition /bin/=
bash&quot; and it returned &quot;Illegal instruction&quot;. At this point i=
 can&#39;t follow the installation and if i force to startup the machine wi=
th that rf system, it returns a &quot;kernel panic&quot; with error to hand=
ling the signal 4 of init process.<br>
<br>I tried to get start the machine with a debain livecd installation. I c=
reated an uImage and initrd from cdrom&#39;s vmlinux and initrd.gz with the=
 uboot-mkimage tool, then i booted it from u-boot but the kernel didn&#39;t=
 start.<br>
<br>I tried to start a preinstalled Debian for a simillar architecture, in =
cocnret from a mpc8561 ppc&#39;s Debian. I put its hhdd with the Debian rfs=
 on my machine and start it with my uImage and dtb files. The results was t=
he same &quot;kernel panic&quot; and signal 4 error.<br>
</div><br><br><br>I accept all ideas.<br><br>Thanks you all and sorry for m=
y english<br><br><br>

--000e0cdfc602e4562a04733a7aab--
