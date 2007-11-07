Return-Path: <olof@lixom.net>
Date: Wed, 7 Nov 2007 14:41:38 -0600
From: Olof Johansson <olof@lixom.net>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: mpc5200, sysctl table check failed
Message-ID: <20071107204138.GA7066@lixom.net>
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 07, 2007 at 03:24:12PM -0500, Jon Smirl wrote:
> I'm porting mpc5200 support for the Phytec pcm030 onto current git
> head. When booting I get this:
> 
> sysctl table check failed: /kernel .1 Writable sysctl directory
> Call Trace:
> [c0817ee0] [c0008034] show_stack+0x50/0x184 (unreliable)
> [c0817f00] [c003cfc8] set_fail+0x50/0x68
> [c0817f20] [c003d630] sysctl_check_table+0x650/0x6a0
> [c0817f50] [c002a9b8] register_sysctl_table+0x64/0xb4
> [c0817f70] [c02dee70] register_powersave_nap_sysctl+0x18/0x2c
> [c0817f80] [c02d81d0] kernel_init+0xb4/0x270
> [c0817ff0] [c0011be0] kernel_thread+0x44/0x60
> 
> What's going on? I get all the way through boot and user space doesn't
> start, this is probably why.

Hi,

I posted a patch for this yesterday, it's harmless, just a warning.


http://patchwork.ozlabs.org/linuxppc/patch?id=14612

-Olof
