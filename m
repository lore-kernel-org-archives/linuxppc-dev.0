Return-Path: <jayaprakashns@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.199])
	by ozlabs.org (Postfix) with ESMTP id AA47867A58
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 16:37:03 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id t14so427796wxc
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Feb 2006 21:37:01 -0800 (PST)
Message-ID: <17f142e10602102137r5990dd0aw83f41fc0eaa5f938@mail.gmail.com>
Date: Sat, 11 Feb 2006 11:07:01 +0530
From: Jayaprakash Shanmugam <jayaprakashns@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Kernel Crash
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello Everyone,

  I am using MPC 8270 based board with 2.6.  It crashes at times.=20
Mostly it is related to timers.  I have attached several crash reports
here.  Anybody can give me some pointers on what could be wrong ? I
really appreciate your help. Thanks.


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# Oops: kernel access of bad area, sig: 11 [#1]

PREEMPT

NIP: C00288C0 LR: C00289FC SP: CF493C80 REGS: cf493bd0 TRAP: 0300    Not ta=
inted

MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C0018F24 LR: C001A174 SP: CF415E90 REGS: cf415de0 TRAP: 0300    Not ta=
inted

MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00C15C74, DSISR: 22000000
TASK =3D c05d7b30[549] 'CCMsgHndlrExe' THREAD: cf414000
Last syscall: 104
GPR00: 00000078 CF415E90 C05D7B30 C05D7B30 C02858AC 2800046C 00000000 C0285=
8B0
GPR08: 00C15C74 00000001 C05D7B50 0000008C B4868000 1003811C 0FFF8000 00000=
000
GPR16: 00000001 7FFFFB30 10016EB9 00000001 00000000 1001751C 10001694 1000E=
668
GPR24: C0290000 C0280000 C02820A8 C0280000 00000000 C0285400 C05D7B30 CF415=
E90
NIP [c0018f24] enqueue_task+0x34/0x7c
LR [c001a174] scheduler_tick+0x300/0x360
Call trace:
 [c0019c18] account_user_time+0x78/0xe8
 [c002924c] update_process_times+0x98/0x150
 [c0005504] timer_interrupt+0x88/0x22c
 [c000448c] ret_from_except+0x0/0x14
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C013CAF8 LR: C013CCC4 SP: C06FDCA0 REGS: c06fdbf0 TRAP: 0300    Not ta=
inted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00C12048, DSISR: 20000000
TASK =3D c05d7b30[495] 'CCMsgHndlrExe' THREAD: c06fc000
Last syscall: 54
GPR00: 00000001 C06FDCA0 C05D7B30 CF64F0F0 CFAF0000 0004DC93 C0280000 C028A=
C8C
GPR08: 00200200 00C12000 00C12048 CF64F0F0 2010C022 1003811C 0FFF8000 00000=
000
GPR16: 00000001 7FFFFB30 10016EB9 00000001 00000000 1001751C 10001694 1000E=
668
GPR24: C0290000 00000001 00000000 CF64F000 CFAF0000 CF64F0F0 00001032 CF64F=
000
NIP [c013caf8] roothub_a+0xc/0x6c
LR [c013ccc4] ohci_hub_status_data+0xa4/0x1a8
Call trace:
 [c0130978] rh_report_status+0x12c/0x164
 [c0029460] run_timer_softirq+0x120/0x228
 [c0024068] __do_softirq+0xd0/0xd8
 [c00240c8] do_softirq+0x58/0x5c
 [c002419c] irq_exit+0x54/0x58
 [c0005668] timer_interrupt+0x1ec/0x22c
 [c000448c] ret_from_except+0x0/0x14
 [d106f5a8] FD_ioctl+0x2160/0x35a8 [FDAC1]
 [c007375c] do_ioctl+0x84/0xac
 [c00739e8] vfs_ioctl+0x88/0x2c8
 [c0073c6c] sys_ioctl+0x44/0x78
 [c0003de0] ret_from_syscall+0x0/0x44

Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D


Oops: kernel access of bad are
a, sig: 11 [#1]
PREEMPT
NIP: C0018F24 LR: C001A174 SP: CF415E90 REGS: cf415de0 TRAP: 0300    Not ta=
inted

MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00C15C74, DSISR: 22000000
TASK =3D c05d7b30[549] 'CCMsgHndlrExe' THREAD: cf414000
Last syscall: 104
GPR00: 00000078 CF415E90 C05D7B30 C05D7B30 C02858AC 2800046C 00000000 C0285=
8B0
GPR08: 00C15C74 00000001 C05D7B50 0000008C B4868000 1003811C 0FFF8000 00000=
000
GPR16: 00000001 7FFFFB30 10016EB9 00000001 00000000 1001751C 10001694 1000E=
668
GPR24: C0290000 C0280000 C02820A8 C0280000 00000000 C0285400 C05D7B30 CF415=
E90
NIP [c0018f24] enqueue_task+0x34/0x7c
LR [c001a174] scheduler_tick+0x300/0x360
Call trace:
 [c0019c18] account_user_time+0x78/0xe8
 [c002924c] update_process_times+0x98/0x150
 [c0005504] timer_interrupt+0x88/0x22c
 [c000448c] ret_from_except+0x0/0x14
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

# Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C0018F24 LR: C001A150 SP: CF415D70 REGS: cf415cc0 TRAP: 0300    Not ta=
inted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00C1580C, DSISR: 22000000
TASK =3D c0525b30[495] 'CCMsgHndlrExe' THREAD: cf414000
Last syscall: 54
GPR00: 00000000 CF415D70 C0525B30 C0525B30 C0285434 00000001 100300EA C0285=
438
GPR08: 00C1580C 00000001 C0525B50 00000076 DB718800 1003807C 0FFF8000 00000=
000
GPR16: 00000001 7FFFFB30 10016EB9 00000001 00000000 1001751C 10001694 1000E=
5C8
GPR24: C0290000 C0280000 C02820A8 C0280000 00000000 C0285400 C0525B30 CF415=
D70
NIP [c0018f24] enqueue_task+0x34/0x7c
LR [c001a150] scheduler_tick+0x2dc/0x360
Call trace:
 [c0019cf0] account_system_time+0x68/0x144
 [c002924c] update_process_times+0x98/0x150
 [c0005504] timer_interrupt+0x88/0x22c
 [c000448c] ret_from_except+0x0/0x14
 [c00739e0] vfs_ioctl+0x80/0x2c8
 [c0073c6c] sys_ioctl+0x44/0x78
 [c0003de0] ret_from_syscall+0x0/0x44

Kernel panic - not syncing: Aiee, killing interrupt handler!

 <0>Rebooting in 180 seconds.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


# Oops: kernel access of bad area, sig: 11 [#1]

PREEMPT
NIP: C0018F24 LR: C001A150 SP: CF415D70 REGS: cf415cc0 TRAP: 0300    Not ta=
inted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00C1580C, DSISR: 22000000
TASK =3D c0525b30[495] 'CCMsgHndlrExe' THREAD: cf414000
Last syscall: 54
GPR00: 00000000 CF415D70 C0525B30 C0525B30 C0285434 00000001 100300EA C0285=
438
GPR08: 00C1580C 00000001 C0525B50 00000076 DB718800 1003807C 0FFF8000 00000=
000
GPR16: 00000001 7FFFFB30 10016EB9 00000001 00000000 1001751C 10001694 1000E=
5C8
GPR24: C0290000 C0280000 C02820A8 C0280000 00000000 C0285400 C0525B30 CF415=
D70
NIP [c0018f24] enqueue_task+0x34/0x7c
LR [c001a150] scheduler_tick+0x2dc/0x360
Call trace:
 [c0019cf0] account_system_time+0x68/0x144
 [c002924c] update_process_times+0x98/0x150
 [c0005504] timer_interrupt+0x88/0x22c
 [c000448c] ret_from_except+0x0/0x14
 [c00739e0] vfs_ioctl+0x80/0x2c8
 [c0073c6c] sys_ioctl+0x44/0x78
 [c0003de0] ret_from_syscall+0x0/0x44
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D


Uninitialised timer!
This is just a warning.  Your computer is OK
function=3D0xc013084c, data=3D0xcfa7e1a0
Call trace:
 [c0006d48] dump_stack+0x18/0x28
 [c0028824] check_timer_failed+0x7c/0x80
 [c0028bc8] mod_timer+0x40/0x8c
 [c01309ac] rh_report_status+0x160/0x164
 [c0029460] run_timer_softirq+0x120/0x228
 [c0024068] __do_softirq+0xd0/0xd8
 [c00240c8] do_softirq+0x58/0x5c
 [c002419c] irq_exit+0x54/0x58
 [c0005668] timer_interrupt+0x1ec/0x22c
 [c000448c] ret_from_except+0x0/0x14
 [d106d50c] FD_ioctl+0xc4/0x35a8 [FDAC1]
 [c007375c] do_ioctl+0x84/0xac
 [c00739e8] vfs_ioctl+0x88/0x2c8
 [c0073c6c] sys_ioctl+0x44/0x78
 [c0003de0] ret_from_syscall+0x0/0x44
Uninitialised timer!

This is just a warning.  Your computer is OK
function=3D0xc013084c, data=3D0xcfa7e1a0
Call trace:
 [c0006d48] dump_stack+0x18/0x28
 [c0028824] check_timer_failed+0x7c/0x80
 [c0028bc8] mod_timer+0x40/0x8c
 [c01309ac] rh_report_status+0x160/0x164
 [c0029460] run_timer_softirq+0x120/0x228
 [c0024068] __do_softirq+0xd0/0xd8
 [c00240c8] do_softirq+0x58/0x5c
 [c002419c] irq_exit+0x54/0x58
 [c0005668] timer_interrupt+0x1ec/0x22c
 [c000448c] ret_from_except+0x0/0x14
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C00293DC LR: C0029384 SP: CF449D50 REGS: cf449ca0 TRAP: 0300    Not ta=
inted
MSR: 00001032 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 0A8324AC, DSISR: 22000000
TASK =3D c05d7b30[549] 'CCMsgHndlrExe' THREAD: cf448000
Last syscall: 54
GPR00: 000AF4C4 CF449D50 C05D7B30 00000001 64F56640 000AF4C3 C0280000 C028A=
E0C
GPR08: C028AE14 CF449D60 CFB224AC 0A8324AC D5990000 10038490 0FFF8000 00000=
000
GPR16: 00000001 7FFFFB30 10016EB9 00000001 00000000 1001751C 10001694 1000E=
734
GPR24: C0290000 C0290000 C0200000 C028A7F4 CF449D60 C028C044 C028A608 00000=
0C3
NIP [c00293dc] run_timer_softirq+0x9c/0x228
LR [c0029384] run_timer_softirq+0x44/0x228
Call trace:
 [c0024068] __do_softirq+0xd0/0xd8
 [c00240c8] do_softirq+0x58/0x5c
 [c002419c] irq_exit+0x54/0x58
 [c0005668] timer_interrupt+0x1ec/0x22c
 [c000448c] ret_from_except+0x0/0x14
 [c00739b8] vfs_ioctl+0x58/0x2c8
 [c0073c6c] sys_ioctl+0x44/0x78
 [c0003de0] ret_from_syscall+0x0/0x44
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

Thanks & Regards,
Jayaprakash.
