Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 612026873D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 21:57:12 +1100 (EST)
Date: Tue, 15 Nov 2005 03:46:34 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Guillaume Autran <gautran@mrv.com>
Message-ID: <20051115054634.GC29963@logos.cnet>
References: <20051107121101.GI15522@logos.cnet> <437920D3.8020105@mrv.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <437920D3.8020105@mrv.com>
Cc: support@abatron.ch, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: BDI2000 and Linux 2.6 kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2005 at 06:42:11PM -0500, Guillaume Autran wrote:
> Hi Marcelo,
> 
> Despite your patch, I'm still having trouble getting my BDI2000 to 
> translate kernel virtual address to physical address on a 2.6.13 kernel.
> 
> What should I look for to make sure I set it up properly ?

Hi Guillaume,

Can you please describe what problems are you having in more detail?

Do you still get "*** MMU: address translation for 0xCxxxxxxx" messages?
