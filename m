Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40711071233x7f892d20g41449cd1e8a34dd4@mail.gmail.com>
Date: Wed, 7 Nov 2007 13:33:01 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jon Smirl" <jonsmirl@gmail.com>
Subject: Re: mpc5200, sysctl table check failed
In-Reply-To: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/7/07, Jon Smirl <jonsmirl@gmail.com> wrote:
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

I see the same thing on the latest git (or at least latest as of last
night); except for me I have no problem with userspace starting.  This
is on a Xilinx Virtex 405.

Cheers,
g.

>
>
> --
> Jon Smirl
> jonsmirl@gmail.com
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
