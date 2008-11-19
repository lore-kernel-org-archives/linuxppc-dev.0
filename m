Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4FC7CDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Nov 2008 03:05:25 +1100 (EST)
Message-ID: <49243934.6030208@freescale.com>
Date: Wed, 19 Nov 2008 10:05:08 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jay_chen <jay_chen@alphanetworks.com>
Subject: Re: MPC8349 DMA
References: <0697112B46494D3DB284F1EBA6F65D4E@alphajay>	<4919CC7D.2070101@freescale.com>
	<6440C70E43EB4F019FF76DFFA4297B2D@alphajay>
In-Reply-To: <6440C70E43EB4F019FF76DFFA4297B2D@alphajay>
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

jay_chen wrote:
> Thanks for your help.
> Could you give some hints about how to  "map your memory as
> coherence-required"?

The M bit needs to be set in the BATs and PTEs.  Current kernels do 
this; I don't know about really old ones such as 2.6.14.

-Scott
