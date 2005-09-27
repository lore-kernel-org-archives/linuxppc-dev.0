Return-Path: <gguevel@interfaceconcept.com>
Received: from relay02s.clb.oleane.net (relay02s.clb.oleane.net
	[213.56.31.143]) by ozlabs.org (Postfix) with ESMTP id 7D97068381
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Sep 2005 01:42:18 +1000 (EST)
Received: from smtp12.clb.oleane.net (smtp12.clb.oleane.net [213.56.31.47])
	by relay02s.clb.oleane.net with ESMTP id j8RFWd4L019094
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Sep 2005 17:32:40 +0200
Received: from GEG2400 ([62.160.30.216]) (authenticated)
	by smtp12.clb.oleane.net with ESMTP id j8RFRhLv007776
	for <linuxppc-embedded@ozlabs.org>; Tue, 27 Sep 2005 17:27:46 +0200
From: =?iso-8859-1?Q?G=E9rard_Gu=E9vel?= <gguevel@interfaceconcept.com>
To: <linuxppc-embedded@ozlabs.org>
Date: Tue, 27 Sep 2005 17:30:25 +0200
Message-ID: <000d01c5c378$64610960$5201a8c0@GEG2400>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <e29792bf3239d4cfb5861e7826300795@freescale.com>
Subject: How to use SPE on MPC8541
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi,

I am running a Linux 2.6.9 on a MPC8541 custom board.

I would like to run a user application which contains
some SPE code extracted from a freescale library.

I compiled the kernel with the CONFIG_SPE set to yes.
The application also compiles and I can run it on the
board.

But it seems the SPE bit from the MSR register
is not set when the process runs.

I tried to use a call to the enable_kernel_spe function
to force the bit, but it is always erased by the kernel (??)
when scheduling task and never set again.

Must I compile the application with some special flags
to instruct the kernel I want to use SPE ?

Thanks for any idea
Gérard
