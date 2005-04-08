Return-Path: <ncaruso@saticoy.hq.irobot.com>
Received: from irobot.com (smtp1.irobot.com [66.238.211.203])
	by ozlabs.org (Postfix) with ESMTP id 8DACE67B27
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Apr 2005 00:07:53 +1000 (EST)
Date: Fri, 8 Apr 2005 09:56:12 -0400
From: nick caruso <ncaruso@saticoy.hq.irobot.com>
Message-Id: <200504081356.j38DuCqe028355@saticoy.hq.irobot.com>
To: linuxppc-embedded@ozlabs.org
Subject: Question about problem with serial line behavior
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

We are bringing up linux on a custom MPC5200 board based on the Lite5200 design published by Freescale.  

We're using u-boot as the boot loader.  We run the console serial line at 115200 Baud.

On some boards, the serial console spews gibberish *after* u-boot has started linux.  On other boards, with exactly the same software, this does not happen.

Linux boots fine in both cases; we can telnet in to the boards and everything seems fine (the console port is even configured correctly according to linux).

But looking at the output on the console serial line with a scope, we can see that the baud rate seems to be set much higher - higher in fact than our line drivers can handle.

To re-iterate, the u-boot loader works fine at 115200 on these boards; it's only after we start the linux kernel that the output becomes gibberish,  And the same software loaded on other boards does not exhibit this behavior.  The other boards are identical in design to the failing boards.

Does anyone have any suggestions as to what might be going wrong here?  

The linux kernel we're using is based on a 2.6.7 kernel.

  any help would be greatly appreciated!

    thanks, and best regards,

      Nick Caruso
      ncaruso@irobot.com
