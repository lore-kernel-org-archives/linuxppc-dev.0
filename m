Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.171])
	by ozlabs.org (Postfix) with ESMTP id 0577867C5C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 07:45:16 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1756396ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 14:45:15 -0700 (PDT)
Message-ID: <45a1b53e0608211445v7ab7052awfff7a9ab8ed5658@mail.gmail.com>
Date: Mon, 21 Aug 2006 16:45:15 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: ML403, ppc 405 crash
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_51093_18036198.1156196715100"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_51093_18036198.1156196715100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  I tried it again.  This time I put updatedb in background.  I'm running an
nfs mount.  I tried doing a make to get fixdep built while updatedb was
running in background:



bash-2.05b# eth0: Could not transmit buffer.
eth0: Could not transmit buffer.
eth0: Could not transmit buffer.
protocol 0800 is buggy, dev eth0
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C01C2744 LR: C01C276C SP: C2E25C90 REGS: c2e25be0 TRAP: 0300    Not
tainted
MSR: 00021030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 00800000
TASK = c2cf6170[1027] 'frcode' THREAD: c2e24000
Last syscall: 234
GPR00: 00021030 C2E25C90 C2CF6170 C3BF4480 C03CC380 C3190810 000005E8
C3CE8880
GPR08: 00000003 00000000 00000008 00000000 35005599 10018E04 100C3248
C02DCE08
GPR16: C00DB1CC C02DCE08 00000002 00000004 C2E25DF8 C02E0000 C02A0000
C2E25CC8
GPR24: 000254C8 C02ED728 C02ED750 00000040 00000000 C03A8800 00000001
C02ED734
NIP [c01c2744] process_backlog+0x80/0x1a0
LR [c01c276c] process_backlog+0xa8/0x1a0
Call trace:
 [c01c2908] net_rx_action+0xa4/0x1cc
 [c001bef4] ___do_softirq+0x7c/0x114
 [c001bfc4] __do_softirq+0x38/0x64
 [c001c080] do_softirq+0x58/0x60
 [c001c0fc] local_bh_enable+0x74/0x80
 [c021f328] __rpc_execute+0x2c0/0x3d4
 [c00dab38] nfs_execute_write+0x3c/0x60
 [c00db084] nfs_flush_list+0x528/0x550
 [c00db1b8] nfs_flush_inode+0x10c/0x120
 [c00dbc44] nfs_sync_inode+0x54/0xb4
 [c00d1660] nfs_file_flush+0x7c/0xf0
 [c005bbbc] filp_close+0xa0/0xd8
 [c00182f0] put_files_struct+0xb0/0x130
 [c0018ab8] do_exit+0x1c0/0xda8
 [c0019714] do_group_exit+0x38/0xf8
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

------=_Part_51093_18036198.1156196715100
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>&nbsp; I tried it again.&nbsp; This time I put updatedb in background.&nbsp; I'm running an nfs mount.&nbsp; I tried doing a make to get fixdep built while updatedb was running in background:<br><br><br><br>bash-2.05b# eth0: Could not transmit buffer.
<br>eth0: Could not transmit buffer.<br>eth0: Could not transmit buffer.<br>protocol 0800 is buggy, dev eth0<br>Oops: kernel access of bad area, sig: 11 [#1]<br>PREEMPT<br>NIP: C01C2744 LR: C01C276C SP: C2E25C90 REGS: c2e25be0 TRAP: 0300&nbsp;&nbsp;&nbsp; Not tainted
<br>MSR: 00021030 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 11<br>DAR: 00000004, DSISR: 00800000<br>TASK = c2cf6170[1027] 'frcode' THREAD: c2e24000<br>Last syscall: 234<br>GPR00: 00021030 C2E25C90 C2CF6170 C3BF4480 C03CC380 C3190810 000005E8 C3CE8880
<br>GPR08: 00000003 00000000 00000008 00000000 35005599 10018E04 100C3248 C02DCE08<br>GPR16: C00DB1CC C02DCE08 00000002 00000004 C2E25DF8 C02E0000 C02A0000 C2E25CC8<br>GPR24: 000254C8 C02ED728 C02ED750 00000040 00000000 C03A8800 00000001 C02ED734
<br>NIP [c01c2744] process_backlog+0x80/0x1a0<br>LR [c01c276c] process_backlog+0xa8/0x1a0<br>Call trace:<br>&nbsp;[c01c2908] net_rx_action+0xa4/0x1cc<br>&nbsp;[c001bef4] ___do_softirq+0x7c/0x114<br>&nbsp;[c001bfc4] __do_softirq+0x38/0x64
<br>&nbsp;[c001c080] do_softirq+0x58/0x60<br>&nbsp;[c001c0fc] local_bh_enable+0x74/0x80<br>&nbsp;[c021f328] __rpc_execute+0x2c0/0x3d4<br>&nbsp;[c00dab38] nfs_execute_write+0x3c/0x60<br>&nbsp;[c00db084] nfs_flush_list+0x528/0x550<br>&nbsp;[c00db1b8] nfs_flush_inode+0x10c/0x120
<br>&nbsp;[c00dbc44] nfs_sync_inode+0x54/0xb4<br>&nbsp;[c00d1660] nfs_file_flush+0x7c/0xf0<br>&nbsp;[c005bbbc] filp_close+0xa0/0xd8<br>&nbsp;[c00182f0] put_files_struct+0xb0/0x130<br>&nbsp;[c0018ab8] do_exit+0x1c0/0xda8<br>&nbsp;[c0019714] do_group_exit+0x38/0xf8
<br>Kernel panic - not syncing: Aiee, killing interrupt handler!<br>&nbsp;&lt;0&gt;Rebooting in 180 seconds..<br>

------=_Part_51093_18036198.1156196715100--
