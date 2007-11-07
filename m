Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711071304l46cb948fk8a1fba27acdd6dac@mail.gmail.com>
Date: Wed, 7 Nov 2007 16:04:03 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: mpc5200, sysctl table check failed
In-Reply-To: <9e4733910711071259n29609954j78d4a3d2050bc267@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910711071224v7bf643bahba0fd23eb2d16ee1@mail.gmail.com>
	<fa686aa40711071233x7f892d20g41449cd1e8a34dd4@mail.gmail.com>
	<9e4733910711071239v6e646590s906f22cb7a9564bb@mail.gmail.com>
	<fa686aa40711071242kd6c3012lf36c0ea22149c9ba@mail.gmail.com>
	<9e4733910711071259n29609954j78d4a3d2050bc267@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

While is was doing "nfs: server 192.168.1.4 not responding, still
trying" it Oops'd.

Oops: Kernel access of bad area, sig: 11 [#1]
pcm030
Modules linked in:
NIP: c01f77a8 LR: c01f778c CTR: 00000000
REGS: c0327c00 TRAP: 0300   Not tainted  (2.6.24-rc2-efika-gf96ef878)
MSR: 00009032 <EE,ME,IR,DR>  CR: 28000044  XER: 00000000
DAR: 005f600f, DSISR: 20000000
TASK = c0305570[0] 'swapper' THREAD: c0326000
GPR00: 7175655f c0327cb0 c0305570 00000119 000099b1 c0952000 00000000 000002e4
GPR08: 00000006 00000001 c0a80105 c034fb9c 330fa340 ffefffff 03ffe000 ffffffff
GPR16: 00000001 00000000 007ffc00 00000000 00000000 03ff8838 00000000 c0327d50
GPR24: 000002d0 000005a8 c0330e7c c0921184 c0327d60 00000464 c0327d50 005f5f77
NIP [c01f77a8] __ip_route_output_key+0x54/0x8f4
LR [c01f778c] __ip_route_output_key+0x38/0x8f4
Call Trace:
[c0327cb0] [c01f802c] __ip_route_output_key+0x8d8/0x8f4 (unreliable)
[c0327d30] [c01f8064] ip_route_output_flow+0x1c/0x74
[c0327d40] [c0221864] inet_sk_rebuild_header+0xb8/0x2c0
[c0327e10] [c0210558] tcp_retransmit_skb+0x478/0x654
[c0327e40] [c0212efc] tcp_write_timer+0x450/0x670
[c0327e60] [c002c5f4] run_timer_softirq+0x12c/0x1b4
[c0327e90] [c00284d0] __do_softirq+0x64/0xd4
[c0327eb0] [c0006144] do_softirq+0x40/0x58
[c0327ec0] [c002837c] irq_exit+0x38/0x48
[c0327ed0] [c000f758] timer_interrupt+0x164/0x180
[c0327ee0] [c0012444] ret_from_except+0x0/0x14
--- Exception: 901 at cpu_idle+0x88/0xd0
    LR = cpu_idle+0x88/0xd0
[c0327fa0] [c0009038] cpu_idle+0xcc/0xd0 (unreliable)
[c0327fb0] [c024fa34] rest_init+0x50/0x60
[c0327fc0] [c02d89c4] start_kernel+0x298/0x2ac
[c0327ff0] [00003438] 0x3438
Instruction dump:
54842834 7c042278 4bffe91d 7c7d1b78 4be30dcd 3d20c033 8129e9d8 57bd103a
7ffd482e 3d20c035 3969fb9c 48000074 <801f0098> 813c000c 7f804800 40be0054
Kernel panic - not syncing: Fatal exception in interrupt
Rebooting in 180 seconds..





-- 
Jon Smirl
jonsmirl@gmail.com
