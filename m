Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A98FFDE235
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 26 Aug 2008 02:52:34 +1000 (EST)
Message-ID: <48B2D0CA.10602@freescale.com>
Date: Mon, 25 Aug 2008 10:33:30 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: virt_to_phys() in drivers w/dma - MPC8xxx
References: <mailman.1.1217383202.19379.linuxppc-embedded@ozlabs.org>
	<6FC450394F2147FDB7EC1D1EB168EB8B@absolutdaddy>
In-Reply-To: <6FC450394F2147FDB7EC1D1EB168EB8B@absolutdaddy>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Russell McGuire wrote:
> So shouldn't we be using like dma_alloc_coherent, and then tracking the dma
> address separately as a variable, and use it when necessary instead of
> calling virt_to_phys()?

Yes.  On 8xxx (but not 8xx, and not with 36-bit memory), there'll be no 
practical difference, but the DMA mapping API *should* be used.

-Scott
