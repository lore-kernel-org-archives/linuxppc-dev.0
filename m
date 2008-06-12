Return-Path: <david.goodenough@linkchoose.co.uk>
Received: from apollo.linkchoose.co.uk (ip-217-204-115-127.easynet.co.uk
	[217.204.115.127]) by ozlabs.org (Postfix) with ESMTP id CDBCEDE151
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 08:06:48 +1000 (EST)
Received: from galaxy.linkchoose.co.uk ([10.98.1.127] helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1K6uIs-00052t-GC
	for linuxppc-embedded@ozlabs.org; Thu, 12 Jun 2008 22:25:54 +0100
Received: from [10.0.1.66] (helo=stargate.dga.co.uk)
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1K6uHy-0005AM-IF
	for linuxppc-embedded@ozlabs.org; Thu, 12 Jun 2008 22:24:58 +0100
From: David Goodenough <david.goodenough@linkchoose.co.uk>
To: linuxppc-embedded@ozlabs.org
Subject: Freescale MPC8321 support
Date: Thu, 12 Jun 2008 22:25:32 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200806122225.33060.david.goodenough@linkchoose.co.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This processor is described as an e300c2 core.  I found that e300c2 is
listed in the arch/powerpc/kernel/cputypes.c file.  Does this mean that it
is supported, or is that just a place holder?  If it is supported (as a core)
what about the peripherals built into the MPC8321 are they likely to be
supported?  How about Flash support, or is this very board dependant?

Any ideas?

David
