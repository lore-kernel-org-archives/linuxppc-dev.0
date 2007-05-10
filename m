Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id 06485DDF0F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 03:41:55 +1000 (EST)
Subject: Fixed PHY problems
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Thu, 10 May 2007 19:41:53 +0200
Message-Id: <1178818913.20638.5.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trying to boot todays linus tree with fixed PHY support enabled gets me this:
Fixed PHY: Registered new driver
Device 'fixed@100:1' does not have a release() function, it is broken and must be fixed.
------------[ cut here ]------------
Badness at drivers/base/core.c:107
Call Trace:
[cffc1dc0] [c0008324] show_stack+0x48/0x194 (unreliable)
[cffc1df0] [c00f4a4c] report_bug+0x84/0xec
[cffc1e00] [c000dde8] program_check_exception+0x274/0x55c
[cffc1e20] [c000f770] ret_from_except_full+0x0/0x4c
--- Exception: 700 at device_release+0x54/0x90
    LR = device_release+0x54/0x90
[cffc1ef0] [c00f5e1c] kobject_cleanup+0xb4/0xb8
[cffc1f10] [c00f6ca0] kref_put+0x68/0x80
[cffc1f20] [c00f5d58] kobject_put+0x24/0x34
[cffc1f30] [c01150bc] put_device+0x1c/0x2c
[cffc1f40] [c0243a9c] fixed_init+0x1cc/0x210
[cffc1f60] [c022e828] kernel_init+0x8c/0x2b4
[cffc1ff0] [c000ff4c] kernel_thread+0x44/0x60

The other thing is, how do I specify a fixed PHY
in OF?

 Jocke
