Message-ID: <002a01c13b93$72b3c5a0$0200a8c0@aiwa>
From: "qiuqingjun" <qiuqingjun@263.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: In initrd, init program is needed or not?
Date: Wed, 12 Sep 2001 22:01:41 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi, all
I am a newbie in ramdisk, I could not find the answers of the following questions in the previous maillists.

There is a program, called init, in some ramdisk.image.gz. however in SIMPLE-ramdisk.image.gz, I did not find it.
I could not understand what the init programe does?

BTW, if I want to access /proc/... , what files should I add in ramdisk. Should I add a program called MOUNT in /bin? who exec rc and fstab script , shell(bash , ash) or kernel?
Thank you in advance.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
