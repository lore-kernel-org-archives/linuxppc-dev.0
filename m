Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <20020429141408.33240.qmail@web15001.mail.bjs.yahoo.com>
Date: Mon, 29 Apr 2002 22:14:08 +0800 (CST)
From: =?gb2312?q?Dross=20Zhou?= <zjuzhou@yahoo.com.cn>
Subject: How to mount romfs in flash as root filesystem?
To: linuxppc-embedded@lists.linuxppc.org
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Content-Transfer-Encoding: 8bit

Hi ,all
	Now my kernel has support ROMFS ,i can mount
/dev/mtdblock0 /mnt -t romfs and use chroot /mnt as
root filesystem.But i want to mount /dev/mtdblock0 as
root filesystem when system reboot,how to?I have try
many parameters into kernel such as "root=/dev/mtdblk0
romfs ro", but it is no use, it also mount NFS
root,how can i mount /dev/mtdblock0 (ROMFS) as root
filesystem?I used linux2.4.4 from denx .
	thanks.

--Zhou Chang




摊开你的掌心 让我看看你
http://sweepstakes.yahoo.com/2002cnuser

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
