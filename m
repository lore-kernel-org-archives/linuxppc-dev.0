Return-Path: <MBenedict@twacs.com>
Received: from outbound8-blu-R.bigfish.com (outbound-blu.frontbridge.com
	[65.55.251.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id F25ACDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Mar 2007 10:42:38 +1100 (EST)
Received: from outbound8-blu.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound8-blu-R.bigfish.com (Postfix) with ESMTP id 408C89DA2D5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 23:42:35 +0000 (UTC)
Received: from mail188-blu-R.bigfish.com (unknown [10.1.252.3])
	by outbound8-blu.bigfish.com (Postfix) with ESMTP id 3217A600052
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 23:42:35 +0000 (UTC)
Received: from mail188-blu (localhost.localdomain [127.0.0.1])
	by mail188-blu-R.bigfish.com (Postfix) with ESMTP id 28EEC5B81E9
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 23:42:35 +0000 (UTC)
Received: from mail.twacs.com (unknown [68.89.149.4])
	by mail188-blu.bigfish.com (Postfix) with ESMTP id 0D6ACF10060
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 Mar 2007 23:42:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: U-boot with flat device tree
Date: Wed, 14 Mar 2007 18:42:18 -0500
Message-ID: <CF7E46FCFF66AD478BB72724345289EC279541@twx-exch01.twacs.local>
In-Reply-To: <20070314180112.15492178.kim.phillips@freescale.com>
References: <CF7E46FCFF66AD478BB72724345289EC27953E@twx-exch01.twacs.local><20070314174644.5a7c1cf0.kim.phillips@freescale.com><CF7E46FCFF66AD478BB72724345289EC27953F@twx-exch01.twacs.local>
	<20070314180112.15492178.kim.phillips@freescale.com>
From: "Benedict, Michael" <MBenedict@twacs.com>
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

ARCH=3Dppc

Thank you so much!  Seems to work now that I am building with
ARCH=3Dpowerpc, I guess I should have spent more time in the beginning
figuring out the difference between ppc and powerpc.

Thank you!!!
	Michael


-----Original Message-----
From: Kim Phillips [mailto:kim.phillips@freescale.com]=20
Sent: Wednesday, March 14, 2007 6:01 PM
To: Benedict, Michael
Subject: Re: U-boot with flat device tree

On Wed, 14 Mar 2007 17:50:45 -0500
"Benedict, Michael" <MBenedict@twacs.com> wrote:

>=20
> If I repeat the above, but call bootm with only the kernel address, I=20
> get a full boot sequence on the console up to the point that the=20
> kernel bails because it is unable to mount the root filesystem.

and you're building the kernel with ARCH=3Dpowerpc?  strange..

Kim
