Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "ByungGiBaek" <weapon100@hanmail.net>
Reply-To: "ByungGiBaek" <weapon100@hanmail.net>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Ppcboot & kernel upgrade problem(2.4.x kernel does not work)
Date: Tue, 15 Jan 2002 15:50:01 +0900 (KST)
Message-Id: <20020115155001.HM.60000000003dHZi@www7.hanmail.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear  all,

Now I'm trying to upgrade linux kernel from 2.2.14 to 2.4.x on our own MPC860T board(50MHz).
I successfully download and boot linux-2.2.14 kernel with ppcboot-0.9.3.

But when I tried to boot linux-2.4.x kernel with same ppcboot and same board,I have some problem.
I just see under messages then the board is auto resetted.
I adjusted IMMR and bd_t of include/asm/my_board.h as ppcboot.h of ppcboot.

Thanks in advance.

=> bootm
## Booting image at 00100000 ...
   Image Name:   2.4.8 for MPC860T Board
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    535804 Bytes = 523 kB = 0 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
## Transferring control to Linux (at address 00000000) ...





ByungGi Baek.
weapon100@hanmail.net


===========================================================================
우리 인터넷, Daum  http://www.daum.net
- 2002 대입 1:1상담,원서접수,합격자발표 ☞ http://hmm.daum.net/daeip_0112
- 인터넷에서 '토정비결' 보세요~ ☞ http://hmm.daum.net/fortune_0112

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
