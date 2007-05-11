Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 49C83DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 11 May 2007 18:07:15 +1000 (EST)
Date: Fri, 11 May 2007 12:07:04 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: joakim.tjernlund@transmode.se
Subject: Re: Fixed PHY problems
Message-ID: <20070511120704.3e0377b7@localhost.localdomain>
In-Reply-To: <1178818913.20638.5.camel@gentoo-jocke.transmode.se>
References: <1178818913.20638.5.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 10 May 2007 19:41:53 +0200
Joakim Tjernlund wrote:

> Trying to boot todays linus tree with fixed PHY support enabled gets
> me this: Fixed PHY: Registered new driver
> Device 'fixed@100:1' does not have a release() function, it is broken
> and must be fixed. ------------[ cut here ]------------
> Badness at drivers/base/core.c:107
> Call Trace:
> [cffc1dc0] [c0008324] show_stack+0x48/0x194 (unreliable)
> [cffc1df0] [c00f4a4c] report_bug+0x84/0xec
> [cffc1e00] [c000dde8] program_check_exception+0x274/0x55c
> [cffc1e20] [c000f770] ret_from_except_full+0x0/0x4c
> --- Exception: 700 at device_release+0x54/0x90
>     LR = device_release+0x54/0x90
> [cffc1ef0] [c00f5e1c] kobject_cleanup+0xb4/0xb8
> [cffc1f10] [c00f6ca0] kref_put+0x68/0x80
> [cffc1f20] [c00f5d58] kobject_put+0x24/0x34
> [cffc1f30] [c01150bc] put_device+0x1c/0x2c
> [cffc1f40] [c0243a9c] fixed_init+0x1cc/0x210
> [cffc1f60] [c022e828] kernel_init+0x8c/0x2b4
> [cffc1ff0] [c000ff4c] kernel_thread+0x44/0x60
> 
> The other thing is, how do I specify a fixed PHY
> in OF?
> 
I have a patch that  fixes it but was busy with other stuff because of merge window.
Can send it to you meanwhile, going to deal with it after next rc released...

>  Jocke
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev


-- 
Sincerely, Vitaly
