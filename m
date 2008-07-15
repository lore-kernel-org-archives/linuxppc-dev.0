Return-Path: <runet@innovsys.com>
Received: from mail.innovsys.com (smtp.innovsys.com [66.115.232.196])
	by ozlabs.org (Postfix) with ESMTP id DF1F5DDF24
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 09:08:45 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: Comiler error compiling 2.6.26
Date: Tue, 15 Jul 2008 18:09:01 -0500
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B04B342D4@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Trying to cross-compile arch/powerpc for an freescale 8280:

Gcc 4.1.2
Binutils 2.17

BFD: ./vmlinux.strip.7812: section .text lma 0xc0000000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .ref.text lma 0xc024f000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .rodata lma 0xc0251000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .pci_fixup lma 0xc02dd2f0 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section __ksymtab lma 0xc02dd930 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section __ksymtab_gpl lma 0xc02e2088 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section __ksymtab_strings lma 0xc02e3a20
overlaps previous sections
BFD: ./vmlinux.strip.7812: section __param lma 0xc02f08cc overlaps
previous sections
BFD: ./vmlinux.strip.7812: section __ex_table lma 0xc02f1000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section __bug_table lma 0xc02f22b8 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .init.text lma 0xc02f8000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .exit.text lma 0xc030f908 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .init.data lma 0xc0310468 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .init.setup lma 0xc0315b70 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .initcall.init lma 0xc0315e28
overlaps previous sections
BFD: ./vmlinux.strip.7812: section .con_initcall.init lma 0xc0316050
overlaps previous sections
BFD: ./vmlinux.strip.7812: section __ftr_fixup lma 0xc0316058 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .machine.desc lma 0xc0317000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .data lma 0xc0318000 overlaps
previous sections
BFD: ./vmlinux.strip.7812: section .data.init_task lma 0xc0330000
overlaps previous sections
BFD: ./vmlinux.strip.7812: section .data.page_aligned lma 0xc0332000
overlaps previous sections
BFD: ./vmlinux.strip.7812: section .data.cacheline_aligned lma
0xc0335000 overlaps previous sections
BFD: ./vmlinux.strip.7812: section .data.read_mostly lma 0xc0335820
overlaps previous sections
