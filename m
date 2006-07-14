Return-Path: <morelli.gab@libero.it>
Received: from smtp7.libero.it (smtp7.libero.it [193.70.192.90])
	by ozlabs.org (Postfix) with ESMTP id 3903C67B85
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jul 2006 05:02:14 +1000 (EST)
Received: from localhost (172.16.1.84) by smtp7.libero.it (7.0.027-DD01)
	id 449964D70209ACF6 for linuxppc-embedded@ozlabs.org;
	Fri, 14 Jul 2006 21:02:11 +0200
Received: from smtp3.libero.it ([172.16.1.53])
	by localhost (asav5.libero.it [193.70.192.154]) (amavisd-new,
	port 10024)
	with ESMTP id 25621-14-5 for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jul 2006 21:02:11 +0200 (CEST)
Received: from libero.it (192.168.17.7) by smtp3.libero.it (7.0.027-DD01)
	id 44755DBA00C85E15 for linuxppc-embedded@ozlabs.org;
	Fri, 14 Jul 2006 21:02:11 +0200
Date: Fri, 14 Jul 2006 21:02:10 +0200
Message-Id: <J2EQ7M$445C72430E3DA56FEDFE22FB6C91499B@libero.it>
Subject: no "ash" process load
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
From: "morelli\.gab" <morelli.gab@libero.it>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi to all 

I have a problem when load the kernel-2.6 in my board.
it can't execute the process ash.
how can i set the file "inittab" in way to resolve the problem?  

this is the message given back.


mtdblock_release
ok
mtdblock_open
ok

.....

mtdblock: read on "cramfs" at 0x93400, size 0x200
mtdblock: read on "cramfs" at 0x93600, size 0x200
mtdblock: read on "cramfs" at 0x93800, size 0x200
mtdblock: read on "cramfs" at 0x93a00, size 0x200
mtdblock: read on "cramfs" at 0x93c00, size 0x200
mtdblock: read on "cramfs" at 0x93e00, size 0x200
Usage: ash 0123456SsQq=F1BbCcUu
Usage: ash 0123456SsQqAaBbCcUu
Usage: ash 0123456SsQqAaBbCcUu
Usage: ash 0123456SsQqAaBbCcUu
Usage: ash 0123456SsQqAaBbCcUu
Usage: ash 0123456SsQqAaBbCcUu
Usage: ash 0123456SsQqAaBbCcUu
Usage: ash 0123456SsQqAaBbCcUu
...

thanks
 
