Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 4590ADE1CE
	for <linuxppc-dev@ozlabs.org>; Fri, 22 May 2009 13:24:07 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1M7LMZ-0004uv-Qg
	for linuxppc-dev@ozlabs.org; Thu, 21 May 2009 20:24:03 -0700
Message-ID: <23663840.post@talk.nabble.com>
Date: Thu, 21 May 2009 20:24:03 -0700 (PDT)
From: "Sauce.Cheng" <chmhou@sina.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: question : DMA of PCI bridge
In-Reply-To: <4A14D12D.4050302@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <23628338.post@talk.nabble.com> <4A137E4F.4040900@ovro.caltech.edu>
	<23647394.post@talk.nabble.com> <4A14D12D.4050302@ovro.caltech.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



>
> in the manual reference charpter 9.13 DMA, source and destination address

> If you are DMAing from an internal peripheral, then it's
> width will be hard-coded and can be read from the user-manual.

you mean it will be set by hard circuit ? maybe i should talk with your hard
engineer.
but as you say, the width will be hard-coded, mean that the width can not be
changed ? 
it can fetch 16 bits to 32bits, can not tetch 16bits to 16bits ?

i am sorry about my poor English, i am not sure if i expressed clearly


> If you are DMAing from a local bus then the local bus definition
> should determine what happens. For example, on the MPC8349, you
> can put 16-bit flash on the local bus, and configure the local
> bus controller to know that it is 16-bits wide. A 32-bit access
> by the CPU or DMA controller will generate two reads on the
> local bus.

that's right, BRx and ORx should be configured for setting width, but that
is bus width, not data width. or bus width should be equal to data width
what fetch from the bus ?

> You can investigate to see whether the MPC8247 works similarly.
all right, i will , thanks a lot

-- 
View this message in context: http://www.nabble.com/question-%3A-DMA-of-PCI-bridge-tp23628338p23663840.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
