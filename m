Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Reply-To: <zjzhou@newrocktech.com>
From: "John Zhou" <zjzhou@newrocktech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: How to change /proc to the writable directory
Date: Fri, 28 Nov 2003 12:30:43 +0800
Message-ID: <000001c3b568$639e70a0$b702a8c0@newrock2>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <3FC65067.4060900@kegel.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I have a based mpc82xx board running embedded linux. But, I met a problem now:

when I boot kernel and mount file system( cramfs and JFFS), for default, the dir /proc is not writable that located in cramfs. Now, I want to change it to be writable. which places/functions should I modify?

In cramfs I have these dirs:
/bin
/root
/boot
/sbin
/usr
/mnt
/dev/ --> /mnt/rwfs/dev
/proc --> /mnt/rwfs/proc
/etc  --> /mnt/rwfs/etc
/tmp  --> /mnt/rwfs/tmp
/var  --> /mnt/rwfs/var
...

In R/W JFFS I have these dirs:

dev
proc
etc
tmp
var

Thanks in advance!
John

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
