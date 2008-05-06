Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D7EB9DE1E2
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 May 2008 05:36:40 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: porting pci driverfrom arch=ppc on kernel 2.6.16 to arch=powerpc
	on	2.6.24...
Date: Tue, 6 May 2008 12:36:19 -0700
Message-ID: <161B3BAD77161449A144FF054231C3D6020D6B08@uss-am-xch-01.am.trimblecorp.net>
References: <161B3BAD77161449A144FF054231C3D6020D6A5D@uss-am-xch-01.am.trimblecorp.net>
	<48209F79.70506@freescale.com>
From: "Mike Timmons" <mike_timmons@trimble.com>
To: "Scott Wood" <scottwood@freescale.com>
Cc: Mark Gibson <Mark_Gibson@Trimble.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If I'm not supposed to read the interrupt using config_read, should I
also not be writing to the host register on the coral P to clear the
interrupt?

Should I instead be using some PCI helper functions?=20

I think I now have a valid interrupt, but seeing it fire continuously
when I know when-and-how it is supposed to fire is the problem now.
Obviously some of the code in the legacy driver for 2.6.16 ppc is not
correct now.

I suspect is it within the MB86290FB_WRITE_HOST_REGISTER() macros that
are used to manipulate the interrupts mask register within the CoralP
PCI graphics controller.=20

Please advise if there is some pci API I should be using to manipulate
this and other registers under the 2.6.24 powerpc kernel.

I do have a few books here with PCI examples but the interrupt
information is sparse.

Thanks again.
-Mike
