Return-Path: <stephane.fillod@thomson.net>
Received: from dmzraw2.extranet.tce.com (dmzraw2.extranet.tce.com
	[157.254.234.138]) by ozlabs.org (Postfix) with ESMTP id E26D867A33
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Apr 2005 22:25:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Date: Tue, 5 Apr 2005 14:25:14 +0200
Message-ID: <1CFEB358338412458B21FAA0D78FE86D4F0D2F@rennsmail02.eu.thmulti.com>
From: "Fillod Stephane" <stephane.fillod@thomson.net>
To: "Kumar Gala" <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org
Subject: RE: [PATCH] invalid instructions in kernel mode
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> What is the crash01 test doing that causes this code to get invoked? =20

crash01[1] (of LTP) is derived from crashme[2], a tool by George J.
Carrette.
It simulates real user programs by generating pseudo-random code and
jumping
into it. This is a great tool to stress test operating system
robustness.
It is very good at testing weird corner cases that no one enjoy doing,=20
eventually finding bugs that may have bitten you in the field.=20
For instance, 2.6.11.6 kernels with math emulation off have a problem
with=20
load/store of fp regs. Please see my question in another mail with Dan.

[1]
http://cvs.sourceforge.net/viewcvs.py/ltp/ltp/testcases/misc/crash/crash
01.c?only_with_tag=3DHEAD&view=3Dmarkup
[2] http://people.delphiforums.com/gjc/crashme.html

> is the kernel you are using using build with math emulation on or off?

My kernel is built with math emulation off. My toolchain is soft-fp
based.


Best Regards,
--=20
Stephane
