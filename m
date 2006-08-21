Return-Path: <wmaxfield@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.170])
	by ozlabs.org (Postfix) with ESMTP id DB41C67BEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Aug 2006 08:20:24 +1000 (EST)
Received: by ug-out-1314.google.com with SMTP id e2so1764939ugf
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 21 Aug 2006 15:20:23 -0700 (PDT)
Message-ID: <45a1b53e0608211520w11f4f29ct88930b7c334509a@mail.gmail.com>
Date: Mon, 21 Aug 2006 17:20:22 -0500
From: "Wade Maxfield" <wmaxfield@gmail.com>
To: ppc <linuxppc-embedded@ozlabs.org>
Subject: ML40x, ppc 405 crash
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_52077_33079708.1156198822774"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_52077_33079708.1156198822774
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

  I was trying to fix the problem with fixdep not being executable.  I was
on the ml403, and have the kernel directory copied into /usr/src/linux and
/usr/src/linux-2.6.10_mvl401:


bash-2.05b# date
Thu Jan  1 00:28:20 UTC 1970
bash-2.05b# date --set "17:11 Aug 21,2006"
Mon Aug 21 17:11:00 UTC 2006
bash-2.05b# date
Mon Aug 21 17:11:03 UTC 2006
bash-2.05b# make clean
  CLEAN   drivers/char
  CLEAN   drivers/video/logo
  CLEAN   init
  CLEAN   kernel
  CLEAN   lib
  CLEAN   usr
  CLEAN   include/asm-ppc/offsets.h
arch/ppc/kernel/asm-offsets.s.tmp_gas_check vmlinux
System.map
bash-2.05b# make config
  HOSTCC  scripts/basic/fixdep
eth0: Could not transmit buffer.
eth0: Could not transmit buffer.
Oops: kernel access of bad area, sig: 11 [#1]
PREEMPT
NIP: C01D0F74 LR: C01D0910 SP: C02ABAE0 REGS: c02aba30 TRAP: 0300    Not
tainted
MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: 00000004, DSISR: 00800000
TASK = c0274710[0] 'swapper' THREAD: c02aa000
Last syscall: 120
GPR00: 00000000 C02ABAE0 C0274710 C3679BC0 C03CC380 C33D6010 000005E8
C3CE8880
GPR08: 00000002 00000000 C3CE890C 00000000 33003099 10018E04 100C3248
C02DCE08
GPR16: C00DB1CC C02DCE08 00000002 00000004 FFFFFFFF C02E0000 C02A0000
C3AEC540
GPR24: 00000000 00000000 00000000 C3AEC540 00000000 C3679BC0 C3CE8880
C03A8800
NIP [c01d0f74] pfifo_fast_dequeue+0x40/0x74
LR [c01d0910] qdisc_restart+0x30/0x2b4
Call trace:
 [c01c1e94] dev_queue_xmit+0x264/0x318
 [c01dd8dc] ip_finish_output+0x140/0x2cc
 [c01dddb0] ip_queue_xmit+0x348/0x53c
 [c01ef628] tcp_transmit_skb+0x324/0x7f8
 [c01f05fc] tcp_write_xmit+0x14c/0x31c
 [c01ed360] __tcp_data_snd_check+0xc8/0xfc
 [c01ed9a4] tcp_rcv_established+0x2c0/0x8ac
 [c01f7250] tcp_v4_do_rcv+0x184/0x374
 [c01f7d9c] tcp_v4_rcv+0x95c/0xa4c
 [c01da000] ip_local_deliver+0x120/0x298
 [c01da86c] ip_rcv+0x400/0x508
 [c01c2614] netif_receive_skb+0x24c/0x2fc
 [c01c276c] process_backlog+0xa8/0x1a0
 [c01c2908] net_rx_action+0xa4/0x1cc
 [c001bef4] ___do_softirq+0x7c/0x114
Kernel panic - not syncing: Aiee, killing interrupt handler!
 <0>Rebooting in 180 seconds..

------=_Part_52077_33079708.1156198822774
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br>&nbsp; I was trying to fix the problem with fixdep not being executable.&nbsp; I was on the ml403, and have the kernel directory copied into /usr/src/linux and /usr/src/linux-2.6.10_mvl401:<br><br><br>bash-2.05b# date<br>Thu Jan&nbsp; 1 00:28:20 UTC 1970
<br>bash-2.05b# date --set &quot;17:11 Aug 21,2006&quot;<br>Mon Aug 21 17:11:00 UTC 2006<br>bash-2.05b# date<br>Mon Aug 21 17:11:03 UTC 2006<br>bash-2.05b# make clean<br>&nbsp; CLEAN&nbsp;&nbsp; drivers/char<br>&nbsp; CLEAN&nbsp;&nbsp; drivers/video/logo
<br>&nbsp; CLEAN&nbsp;&nbsp; init<br>&nbsp; CLEAN&nbsp;&nbsp; kernel<br>&nbsp; CLEAN&nbsp;&nbsp; lib<br>&nbsp; CLEAN&nbsp;&nbsp; usr<br>&nbsp; CLEAN&nbsp;&nbsp; include/asm-ppc/offsets.h arch/ppc/kernel/asm-offsets.s .tmp_gas_check vmlinux System.map<br>bash-2.05b# make config<br>&nbsp; HOSTCC&nbsp; scripts/basic/fixdep
<br>eth0: Could not transmit buffer.<br>eth0: Could not transmit buffer.<br>Oops: kernel access of bad area, sig: 11 [#1]<br>PREEMPT<br>NIP: C01D0F74 LR: C01D0910 SP: C02ABAE0 REGS: c02aba30 TRAP: 0300&nbsp;&nbsp;&nbsp; Not tainted<br>MSR: 00029030 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
<br>DAR: 00000004, DSISR: 00800000<br>TASK = c0274710[0] 'swapper' THREAD: c02aa000<br>Last syscall: 120<br>GPR00: 00000000 C02ABAE0 C0274710 C3679BC0 C03CC380 C33D6010 000005E8 C3CE8880<br>GPR08: 00000002 00000000 C3CE890C 00000000 33003099 10018E04 100C3248 C02DCE08
<br>GPR16: C00DB1CC C02DCE08 00000002 00000004 FFFFFFFF C02E0000 C02A0000 C3AEC540<br>GPR24: 00000000 00000000 00000000 C3AEC540 00000000 C3679BC0 C3CE8880 C03A8800<br>NIP [c01d0f74] pfifo_fast_dequeue+0x40/0x74<br>LR [c01d0910] qdisc_restart+0x30/0x2b4
<br>Call trace:<br>&nbsp;[c01c1e94] dev_queue_xmit+0x264/0x318<br>&nbsp;[c01dd8dc] ip_finish_output+0x140/0x2cc<br>&nbsp;[c01dddb0] ip_queue_xmit+0x348/0x53c<br>&nbsp;[c01ef628] tcp_transmit_skb+0x324/0x7f8<br>&nbsp;[c01f05fc] tcp_write_xmit+0x14c/0x31c
<br>&nbsp;[c01ed360] __tcp_data_snd_check+0xc8/0xfc<br>&nbsp;[c01ed9a4] tcp_rcv_established+0x2c0/0x8ac<br>&nbsp;[c01f7250] tcp_v4_do_rcv+0x184/0x374<br>&nbsp;[c01f7d9c] tcp_v4_rcv+0x95c/0xa4c<br>&nbsp;[c01da000] ip_local_deliver+0x120/0x298<br>&nbsp;[c01da86c] ip_rcv+0x400/0x508
<br>&nbsp;[c01c2614] netif_receive_skb+0x24c/0x2fc<br>&nbsp;[c01c276c] process_backlog+0xa8/0x1a0<br>&nbsp;[c01c2908] net_rx_action+0xa4/0x1cc<br>&nbsp;[c001bef4] ___do_softirq+0x7c/0x114<br>Kernel panic - not syncing: Aiee, killing interrupt handler!
<br>&nbsp;&lt;0&gt;Rebooting in 180 seconds..<br>

------=_Part_52077_33079708.1156198822774--
