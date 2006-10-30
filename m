Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 030FB67C7A
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 22:33:45 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id C5BE129EC8
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 12:05:16 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 14113-02 for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 12:05:03 +0100 (CET)
Received: from [192.168.1.153] (unknown [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 6D62429EC3
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 30 Oct 2006 12:05:03 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: "linuxppc-embedded list" <linuxppc-embedded@ozlabs.org>
Subject: Xubuntu and Xenomai on the Lite5200 (IceCube)...
Date: Mon, 30 Oct 2006 12:09:37 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200610301209.38103.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all,

I got the task to help make Linux run on the IceCube, with support for MSCAN, 
FEC and USB. After a rather exciting jurney I managed to get kernel 2.6.18 
working with bestcomm DMA and FEC support backported from DENX's git 
2.6.19-rcsomething, and Xenomai installed upon that.
Btw, before Wolfgang Denk starts complaining why I didn't use his 2.4 kernel, 
it's because I wasn't smart enough to get USB working. If it does work, 
please tell me how, I just get errors when plugging in a USB device "kernel: 
usb.c: USB device not accepting new address=2 (error=-110)". 
This seems to work fine in 2.6, though.
It was not easy, so I wrote everything down (I hope I didn't forget anything 
important):

http://yopesblog.blogspot.com/2006/10/how-to-run-ubuntu-and-xenomai-on.html

If anyone wants to tell me what I did wrong (probably a lot), please tell me.
I am posting this to the list hoping someone else will benefit from it. I 
certainly would have.

Greetings,

-- 
David Jander
