Return-Path: <jayaprakashns@gmail.com>
Received: from xproxy.gmail.com (xproxy.gmail.com [66.249.82.198])
	by ozlabs.org (Postfix) with ESMTP id 23C41689B5
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  7 Jan 2006 01:47:42 +1100 (EST)
Received: by xproxy.gmail.com with SMTP id i27so2092624wxd
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 06 Jan 2006 06:47:41 -0800 (PST)
Message-ID: <17f142e10601060647g60661eb0uc84ca48eca99031b@mail.gmail.com>
Date: Fri, 6 Jan 2006 20:17:40 +0530
From: Jayaprakash Shanmugam <jayaprakashns@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: OOPS!!! - Help.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
  I am using 2.6 kernel on MPC 8270.  After 15-20 mins, I got the
following crash from my application.  I dont have any clue on what
could be wrong.  Can you help me out ?

kernel BUG in page_remove_rmap at mm/rmap.c:482!
Oops: Exception in kernel mode, sig: 5 [#1]
PREEMPT
NIP: C0055F18 LR: C004E4EC SP: C066DC50 REGS: c066dba0 TRAP: 0700    Not ta=
inted

MSR: 00029032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
TASK =3D c0705b30[398] 'CCMsgHndlrExe' THREAD: c066c000
Last syscall: 117
GPR00: C0377388 C066DC50 C0705B30 C0377380 FFFFFFFF 10006000 00000040 00200=
200
GPR08: 00100100 00000001 00000000 FFFFFFFF 88008222 10037DE0 00000000 C0280=
000
GPR16: 00000000 C066DDAC 00000001 CE9C5D20 C0280000 00000001 10006000 06A9C=
305
GPR24: 1000C000 C02839A0 00008000 C0377380 00000000 FFFFFFFD 00006000 C0773=
030
NIP [c0055f18] page_remove_rmap+0x54/0x68
LR [c004e4ec] zap_pte_range+0x1a4/0x30c
Call trace:
 [c004e4ec] zap_pte_range+0x1a4/0x30c
 [c004e69c] zap_pmd_range+0x48/0x84
 [c004e718] zap_pud_range+0x40/0x78
 [c004e7f8] unmap_page_range+0xa8/0xc8
 [c004e964] unmap_vmas+0x14c/0x234
 [c0053cd8] exit_mmap+0x6c/0x168
 [c001bcdc] mmput+0x54/0xe4
 [c00206f4] exit_mm+0x168/0x1d0
 [c00210bc] do_exit+0xc8/0x3f8
 [c002146c] do_group_exit+0x38/0xd8
 [c002caa8] get_signal_to_deliver+0x1a8/0x344
 [c0007d38] do_signal+0x38/0x24c
 [c0004614] do_user_signal+0x74/0xc4
note: CCMsgHndlrExe[398] exited with preempt_count 1
scheduling while atomic: CCMsgHndlrExe/0x00000002/398
Call trace:
 [c0006d48] dump_stack+0x18/0x28
 [c01b906c] schedule+0x654/0x658
 [c01b9e04] schedule_timeout+0x84/0xdc
 [c0147cc4] sxc_close+0x88/0xc4
 [c00f98c0] release_dev+0x7b8/0x7cc
 [c00f9ed4] tty_release+0x20/0x3c
 [c005e8dc] __fput+0x174/0x180
 [c005e764] fput+0x3c/0x40
 [c005cbe8] filp_close+0x78/0xbc
 [c0020240] put_files_struct+0xac/0x110
 [c00210f8] do_exit+0x104/0x3f8
 [c00047c8] die+0xbc/0xc4
 [c0004840] _exception+0x70/0x74
 [c0004440] ret_from_except_full+0x0/0x4c
 [c0055f18] page_remove_rmap+0x54/0x68

Regards,
Jayaprakash.
