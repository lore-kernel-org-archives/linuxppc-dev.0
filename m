Return-Path: <dpelton@ciena.com>
Received: from mdmxm02.ciena.com (LIN1-118-39-27.ciena.com [63.118.39.27])
	by ozlabs.org (Postfix) with ESMTP id B6C63679FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Feb 2006 17:07:07 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: UTOPIA support for MPC885 with 2.6.15 kernel
Date: Fri, 24 Feb 2006 00:54:39 -0500
Message-ID: <3B9518857C91E345AA1806A6F53C0EB701596AF2@onmxm01.ciena.com>
From: "Pelton, Dave" <dpelton@ciena.com>
To: <linuxppc-embedded@ozlabs.org>
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

I am currently working with a MPC885ADS board running a 2.6.15 kernel
build.  I have been attempting to get the UTOPIA interface working, but
I have not been able to find kernel code (or patches) to do this. =20

The closest I have found so far is the MPC860/862 ATM driver on
SourceForge.  Unfortunately this driver was written for the 2.4 kernel,
and does not include MPHY support for ESAR mode.  I have been able to
get this code to compile and run on my kernel, and now I am digging into
the ESAR/MPHY support stuff. =20

I was wondering if anyone else has already done anything along these
lines (either a ESAR/MPHY driver or MPC855 UTOPIA support on the 2.6
kernel), as I would prefer to build on existing code rather than gluing
this stuff together myself.

- Thanks,
  David Pelton.
