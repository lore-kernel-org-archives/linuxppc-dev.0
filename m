Return-Path: <nanda74pg@rediffmail.com>
Received: from rediffmail.com (f5mail-237-241.rediffmail.com [202.137.237.241])
	by ozlabs.org (Postfix) with SMTP id 5EC43B7B83
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Sep 2009 01:11:55 +1000 (EST)
Date: 16 Sep 2009 15:02:33 -0000
Message-ID: <20090916150233.33919.qmail@f5mail-237-241.rediffmail.com>
MIME-Version: 1.0
To: <linuxppc-dev@ozlabs.org>
Subject: Crash in the kernel panic linux mpc 832x
From: "nanda" <nanda74pg@rediffmail.com>
Content-Type: multipart/alternative;
	boundary="=_a8755decb4db200659e5dad3a68be448"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--=_a8755decb4db200659e5dad3a68be448
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="ISO-8859-1"

Hi,
  Iam getting the below crash on new board tested on MPC832x using linux-2.6.24, please let me what could be the problem on the same. Does it infer any information on the exception?

# Oops: Exception in kernel mode, sig: 4 [#1]
PREEMPT MPC832x RDB
Modules linked in:
NIP: c0048178 LR: c00463e8 CTR: c000ce44
REGS: c018dc60 TRAP: 0700   Not tainted  (2.6.24)
MSR: 00001032   CR: 82022028  XER: 00000000
TASK = c017b570[0] 'swapper' THREAD: c018c000
GPR00: 3b9ac9ff c018dd10 c017b570 c017c9f0 00000016 c0192180 00000000 000015cc
GPR08: fd82b91c 00000000 328b73f6 00000000 328b89c2 76ef53cb 00000000 328b73f6
GPR16: c019c990 ffffffff fffce4b8 ffffffff ffff392e 00000000 000000ba ffffffff
GPR24: fffdf72b ffffffff ffffff46 00000000 000208d5 fd41cc00 ffffffff fffffff6
NIP [c0048178] clocksource_get_next+0x0/0xa8
LR [c00463e8] update_wall_time+0x50c/0xccc
Call Trace:
[c018dd10] [c0046624] update_wall_time+0x748/0xccc (unreliable)
[c018ddd0] [c0031b68] do_timer+0x40/0xf0
[c018ddf0] [c004a7a4] tick_sched_timer+0x284/0x2e8
[c018de40] [c0043cc4] hrtimer_interrupt+0x1c8/0x2d4
[c018dea0] [c000d038] timer_interrupt+0x128/0x188
[c018dec0] [c0010208] ret_from_except+0x0/0x14
--- Exception: 901 at cpu_idle+0x98/0xf8
    LR = cpu_idle+0x98/0xf8
[c018df80] [c00091c0] cpu_idle+0xdc/0xf8 (unreliable)
[c018dfa0] [c0003e98] rest_init+0x8c/0xb4
[c018dfc0] [c015fa28] start_kernel+0x258/0x2e4
[c018dff0] [00003438] 0x3438
Instruction dump:
40820028 38000a00 387e0001 b01e0000 7c7f1850 80010014 bbc10008 38210010
7c0803a6 4e800020 480d643d 4bffffd8  7c0802a6 93e1000c 90010014
Kernel panic - not syncing: Fatal exception in interrupt--


Regards,
Nanda
--=_a8755decb4db200659e5dad3a68be448
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset="ISO-8859-1"

Hi,<br />
  Iam getting the below crash on new board tested on MPC832x using linux-2.=
6.24, please let me what could be the problem on the same. Does it infer an=
y information on the exception?<br />
<br />
# Oops: Exception in kernel mode, sig: 4 [#1]<br />
PREEMPT MPC832x RDB<br />
Modules linked in:<br />
NIP: c0048178 LR: c00463e8 CTR: c000ce44<br />
REGS: c018dc60 TRAP: 0700   Not tainted  (2.6.24)<br />
MSR: 00001032 <ME,IR,DR>  CR: 82022028  XER: 00000000<br />
TASK =3D c017b570[0] 'swapper' THREAD: c018c000<br />
GPR00: 3b9ac9ff c018dd10 c017b570 c017c9f0 00000016 c0192180 00000000 00001=
5cc<br />
GPR08: fd82b91c 00000000 328b73f6 00000000 328b89c2 76ef53cb 00000000 328b7=
3f6<br />
GPR16: c019c990 ffffffff fffce4b8 ffffffff ffff392e 00000000 000000ba fffff=
fff<br />
GPR24: fffdf72b ffffffff ffffff46 00000000 000208d5 fd41cc00 ffffffff fffff=
ff6<br />
NIP [c0048178] clocksource_get_next+0x0/0xa8<br />
LR [c00463e8] update_wall_time+0x50c/0xccc<br />
Call Trace:<br />
[c018dd10] [c0046624] update_wall_time+0x748/0xccc (unreliable)<br />
[c018ddd0] [c0031b68] do_timer+0x40/0xf0<br />
[c018ddf0] [c004a7a4] tick_sched_timer+0x284/0x2e8<br />
[c018de40] [c0043cc4] hrtimer_interrupt+0x1c8/0x2d4<br />
[c018dea0] [c000d038] timer_interrupt+0x128/0x188<br />
[c018dec0] [c0010208] ret_from_except+0x0/0x14<br />
--- Exception: 901 at cpu_idle+0x98/0xf8<br />
    LR =3D cpu_idle+0x98/0xf8<br />
[c018df80] [c00091c0] cpu_idle+0xdc/0xf8 (unreliable)<br />
[c018dfa0] [c0003e98] rest_init+0x8c/0xb4<br />
[c018dfc0] [c015fa28] start_kernel+0x258/0x2e4<br />
[c018dff0] [00003438] 0x3438<br />
Instruction dump:<br />
40820028 38000a00 387e0001 b01e0000 7c7f1850 80010014 bbc10008 38210010<br =
/>
7c0803a6 4e800020 480d643d 4bffffd8 <9421fff0> 7c0802a6 93e1000c 90010014<b=
r />
Kernel panic - not syncing: Fatal exception in interrupt--<br />
<br />
<br />
Regards,<br />
Nanda<br><Table border=3D0 Width=3D644 Height=3D57 cellspacing=3D0 cellpadd=
ing=3D0 style=3D"font-family:Verdana;font-size:11px;line-height:15px;"><TR>=
<td><A HREF=3D"http://sigads.rediff.com/RealMedia/ads/click_nx.ads/www.redi=
ffmail.com/signatureline.htm@Middle?" target=3D"_blank"><IMG SRC=3D"http://=
sigads.rediff.com/RealMedia/ads/adstream_nx.ads/www.rediffmail.com/signatur=
eline.htm@Middle"></A></td></TR></Table>
--=_a8755decb4db200659e5dad3a68be448--
