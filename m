Message-ID: <20020321023830.1777.qmail@kunk.jriver.com>
Subject: cat /proc/cpuinfo oops in 2.4.19-pre3-ben0
To: linuxppc-dev@lists.linuxppc.org
Date: Wed, 20 Mar 2002 20:38:29 -0600 (CST)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Supermac S900 w/ 604e 233 and  256 megs ram. Worked fine in
2.4.17-ben0

Gives the following dmesg:

Oops: kernel access of bad area, sig: 11
NIP: C01F584C XER: 20000000 LR: C01F64EC SP: CE6B5DA0 REGS: ce6b5cf0 TRAP: 0300    Not tainted
MSR: 00009032 EE: 1 PR: 0 FP: 0 ME: 1 IR/DR: 11
DAR: FFFFFFED, DSISR: 40000000
TASK = ce6b4000[1604] 'top' Last syscall: 3
last math ce6b4000 last altivec 00000000
GPR00: CE6B5DE8 CE6B5DA0 CE6B4000 FFFFFFED FFFFFFFE C01FC68A 00000020 0000000A
GPR08: FFFFFFFF FFFFFFED C01F64A0 00000004 82042823 10021FA0 00000000 00000000
GPR16: 00000000 00000000 00000000 00000000 00009032 0E6B5F40 00000000 CE87B0E0
GPR24: 00000F78 CD819088 CD819FFF 00000000 FFFFFFFF CD81909B CE6B5E50 FFFFFFED
Call backtrace:
C01F6830 C0054984 C02B7564 C0009894 C00542C0 C0037F30 C0003BDC
0FE800C8 0FE7E628 0FE80128 0FE7FF20 0FE7403C 0FE73EAC 0FE7D914
0FEE2664 0FEB4270 100016C8 10001D84 0FE27D74 00000000

Bob
--
Robert E. Brose II    N0QBJ
http://www.qbjnet.com/
mailto:bob@qbjnet.com
public key available at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
