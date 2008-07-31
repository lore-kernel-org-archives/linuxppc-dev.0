Return-Path: <SSparks@aclaratech.com>
Received: from VA3EHSOBE003.bigfish.com (outbound-va3.frontbridge.com
	[216.32.180.16]) by ozlabs.org (Postfix) with ESMTP id BA1B2DDF0F
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 23:15:53 +1000 (EST)
Received: from mail105-va3 (localhost.localdomain [127.0.0.1])	by
	mail105-va3-R.bigfish.com (Postfix) with ESMTP id 8F2191CB05C9	for
	<linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:15:49 +0000 (UTC)
Received: from acl-exch.aclaratech.com (unknown [68.89.149.23])	by
	mail105-va3.bigfish.com (Postfix) with ESMTP id BC0A05E0073	for
	<linuxppc-dev@ozlabs.org>; Thu, 31 Jul 2008 13:15:47 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Subject: Compact Flash on 8349mITX
Date: Thu, 31 Jul 2008 08:14:23 -0500
Message-ID: <6011A7C9CD0EE74792C3ED2A83556086342189@mail.twacs.com>
From: "Sparks, Sam" <SSparks@aclaratech.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello All,

I'm using the latest 2.2.26 kernel image from
linux/kernel/git/benh/powerpc.git on a mpc8349mITX, and trying to get
Compact Flash to work. The kernel booted fine, but I was surprised to
see Compact Flash IRQ was not being handled. Does irq polling need to be
used for compact flash to work with this version of the kernel on this
board?

Here's snip of the unhandled IRQ, for your edification.

irq 23: nobody cared (try booting with the "irqpoll" option)
Call Trace:
[cf829a30] [c00087d4] 0xc00087d4 (unreliable)
[cf829a60] [c0052844] 0xc0052844
[cf829a80] [c0052ac4] 0xc0052ac4
[cf829ac0] [c0053520] 0xc0053520
[cf829ad0] [c000581c] 0xc000581c
[cf829ae0] [c0012adc] 0xc0012adc
--- Exception: 501 at 0xc002f1e0
    LR =3D 0xc00058c8
[cf829ba0] [c02d4ef8] 0xc02d4ef8 (unreliable)
[cf829bd0] [c00058c8] 0xc00058c8
[cf829be0] [c002f394] 0xc002f394
[cf829bf0] [c0005820] 0xc0005820
[cf829c00] [c0012adc] 0xc0012adc
--- Exception: 501 at 0xc0052450
    LR =3D 0xc0052574
[cf829cf0] [c00527e0] 0xc00527e0
[cf829d20] [c0053a04] 0xc0053a04
[cf829d40] [c01a7d88] 0xc01a7d88
[cf829d70] [c029a5bc] 0xc029a5bc
[cf829db0] [c029a8b4] 0xc029a8b4
[cf829e40] [c0202d10] 0xc0202d10
[cf829e60] [c017ab60] 0xc017ab60
[cf829e80] [c017ad6c] 0xc017ad6c
[cf829ea0] [c0179758] 0xc0179758
[cf829ed0] [c017adc4] 0xc017adc4
[cf829ee0] [c017a180] 0xc017a180
[cf829f10] [c017b39c] 0xc017b39c
[cf829f30] [c0202f80] 0xc0202f80
[cf829f40] [c0320750] 0xc0320750
[cf829f50] [c03007ac] 0xc03007ac
[cf829fd0] [c0300994] 0xc0300994
[cf829ff0] [c0012268] 0xc0012268
handlers:
[<c01b35c0>]
Disabling IRQ #23


Thanks for the help,
Sam
