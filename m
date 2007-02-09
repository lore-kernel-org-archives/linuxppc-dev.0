Return-Path: <linuxppcdev@qbjnet.com>
Received: from kunk.qbjnet.com (ddsl1-28.ddsl.mr.net [137.192.135.28])
	by ozlabs.org (Postfix) with SMTP id EC633DDE3A
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 05:07:56 +1100 (EST)
Date: 9 Feb 2007 18:07:55 -0000
Message-ID: <20070209180755.26640.qmail@kunk.qbjnet.com>
From: Bob Brose <linuxppcdev@qbjnet.com>
To: linuxppc-dev@ozlabs.org
Subject: 2.6.20 zImage.prep??
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is PReP currently suported? The last kernel version I could make a
zImage.prep in was 2.6.14. I see some references to PReP and new
kernels here but nothing I'd call definitive.

>From digging around the net it looks like one is supposed to use
mkvmlinuz to do this now however:

1) The utilities mkprep, mktree and mkbugboot aren't build be default
in 2.6.20 from what I can see and

2) Even when I build them and try mkvmlinuz there are errors:
debian:/usr/src/linux# mkvmlinuz -v -o vmlinuz.prep -a prep -k vmlinux -r 2.4.20
=== Building for sub-architecture prep.
=== Using kernel image file vmlinux.
=== Release version seems to be 2.4.20.
=== Using object files from /usr/src/linux.
=== Building a bootable compressed kernel image in vmlinuz.prep.
=== Doing build in /tmp/tmp.kTUDZ23437.
=== Creating compressed kernel image vmlinux.gz...
objcopy -O binary vmlinux /tmp/tmp.kTUDZ23437/vmlinux
gzip /tmp/tmp.kTUDZ23437/vmlinux
=== Putting everything into ELF image file image.o...
objcopy -R .comment /tmp/tmp.kTUDZ23437/image.o
objcopy: '/tmp/tmp.kTUDZ23437/image.o': No such file
objcopy: error: the input file '/tmp/tmp.kTUDZ23437/image.o' is empty
objcopy /tmp/tmp.kTUDZ23437/image.o /tmp/tmp.kTUDZ23437/image.o --add-section=.image=/tmp/tmp.kTUDZ23437/vmlinux.gz --set-section-flags=.image=contents,alloc,load,readonly,data
objcopy: '/tmp/tmp.kTUDZ23437/image.o': No such file
objcopy: error: the input file '/tmp/tmp.kTUDZ23437/image.o' is empty
=== Creating bootable kernel image file vmlinuz.prep...
Sorry, I do not know how to handle PowerPC sub-architecture prep in version 2.4.20.

This is debian sid. If I try the mkvmlinuz command for chrp it works fine.

Regards,
Bob
