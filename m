Message-ID: <35C119252057D511BB9F0003476BF8A208E5E2@freexc01.smartm.com>
From: "Prasad, Siva" <Siva.Prasad@smartm.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Root login...
Date: Thu, 4 Oct 2001 15:43:02 -0700 
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I used HHL Journeyman 2.0 PPC 7xx to build ramdisk for our custom PPC 750
board. When I try to execute, it gives the login prompt. But when I type
'root' and hit enter, it gives me back login prompt again. Basically it is
not logging in.

What might be the problem that is causing this?. I tried with just "/bin/sh"
and it directly gives me the shell prompt as expected... when I put
"/sbin/init", it gives this login problem.

Any help would be great.

Am I missing any files???.
I put the following files in ramdisk...

/bin
bash cat cp date echo ls mount ping ps sh stty umount

/dev
console ram0 tty ttyS0

/sbin
fsck getty halt ifconfig init insmod lsmod modprobe reboot shutdown sulogin

/etc
fstab (with /dev/root, /dev/ram0 and /proc)
passwd
group
inittad (as is from HHL Journeyman)
rc.d (as is from HHL Journeyman)
init.d (as is from HHL Journeyman)
default (as is from HHL Journeyman)

and create few other directories...
/root /proc /mnt /usr /tmp /var

-- Siva

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
