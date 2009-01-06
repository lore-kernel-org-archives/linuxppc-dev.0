Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 19A0CDE014
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 01:03:12 +1100 (EST)
Date: Tue, 6 Jan 2009 17:03:10 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Leon Woestenberg <leon.woestenberg@gmail.com>
Subject: Re: 2.6.28 does not boot on MPC8315E-RDB, or...?
Message-ID: <20090106140310.GA1244@oksana.dev.rtsoft.ru>
References: <c384c5ea0901031458j74d74ba3y359831fff9716d07@mail.gmail.com>
	<008601c96e04$18b74bc0$6b03a8c0@sdelaney2>
	<c384c5ea0901031645q6358f5deibca91cb065fbeb32@mail.gmail.com>
	<20090105165817.GA24565@oksana.dev.rtsoft.ru>
	<c384c5ea0901051407i2f1b418ep56c2a9f20268459a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <c384c5ea0901051407i2f1b418ep56c2a9f20268459a@mail.gmail.com>
Cc: Linux PPC <linuxppc-dev@ozlabs.org>, onramp123@yahoo.com
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 11:07:07PM +0100, Leon Woestenberg wrote:
[...]
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> Oops: Machine check, sig: 7 [#1]
> MPC831x RDB
> Modules linked in:
> NIP: c01ed380 LR: c01ed36c CTR: 00000000
> REGS: c7827c70 TRAP: 0200   Not tainted  (2.6.28)
> MSR: 00049030 <EE,ME,IR,DR>  CR: 84044028  XER: 00000000
> TASK = c7828000[1] 'swapper' THREAD: c7826000
> GPR00: 00000000 c7827d20 c7828000 c9064000 e0023000 000005a9 c0066260 c0397248
> GPR08: c7863540 00000000 c7860190 e00235a9 84044042 00008880 07ff9000 ffffffff
> GPR16: 00000000 007fff00 00000000 007ffeb0 00000000 00000000 07ff61d8 00000000
> GPR24: 00000000 00000026 fffffff2 c02d87cc c7825008 c7825094 c79cde00 c036af0c
> Call Trace:
> [c7827d20] [c01ed36c] 0xc01ed36c (unreliable)
> [c7827d50] [c0183558] 0xc0183558
> [c7827d60] [c01823d4] 0xc01823d4
> [c7827d80] [c01825a8] 0xc01825a8
> [c7827da0] [c01818d8] 0xc01818d8
> [c7827dd0] [c01821dc] 0xc01821dc
> [c7827de0] [c0181f28] 0xc0181f28
> [c7827e10] [c01827b8] 0xc01827b8
> [c7827e30] [c01837b4] 0xc01837b4
> [c7827e40] [c0352630] 0xc0352630
> [c7827e60] [c0003874] 0xc0003874
> [c7827fd0] [c0337168] 0xc0337168
> [c7827ff0] [c0010de0] 0xc0010de0
> Instruction dump:
> 4be389d9 2f830000 419e009c 807e00a4 3b40fff2 809e00ac 4be27829 2f830000
> 907e0098 419e0070 7c0004ac 80030500 <0c000000> 4c00012c 60000004 817e0098
> ---[ end trace 2de2fe77d47e0f5d ]---
> Kernel panic - not syncing: Attempted to kill init!
> Rebooting in 180 seconds..

Can you please enable CONFIG_KALLSYMS in the .config file? Otherwise
the trace is useless.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
