Message-ID: <6B546A602AD2D211BFF00008C7A4288905843F7A@hrtades2.atea.be>
From: Goddeeris Frederic <Frederic.Goddeeris@siemens.atea.be>
To: "'Gerhard TAEUBL '" <Gerhard.TAEUBL@frequentis.com>,
	"'linuxppc-embedded@lists.linuxppc.org '" <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Password for embedded Linux
Date: Thu, 13 Dec 2001 11:06:20 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 My experience is that you need to include a lot of things for the login.
I used TinyLogin. This will provide everything you need (I also used
Busybox)
In /etc/inittab I added
	ttyS0::respawn:/sbin/getty -L ttyS0 9600 vt100
/sbin/getty points to TinyLogin
getty -> ../bin/tinylogin

You have good experience with JFFS2? What version do you use?

Fred

-----Original Message-----
From: Gerhard TAEUBL
To: linuxppc-embedded@lists.linuxppc.org
Sent: 12/13/01 10:49 AM
Subject: Password for embedded Linux


Hi!

We use HHL1.2 filesystem for a MPC860. Meanwhile everthing works fine
:-) (serial port, jffs2 and so on). I've made a initrd to boot the
system and mount 4MB Flash where the project related data and programs
will be copied. So we could use for nearly every project the same image,
and store the data afterwards via ftp. O.K. but we want to use a
password to login, and I didn't find any hint to do that! So if you have
any ideas...
Thanks in advance
Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
