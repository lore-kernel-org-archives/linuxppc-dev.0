Return-Path: <marcelo.tosatti@cyclades.com>
Received: from hera.kernel.org (hera.kernel.org [140.211.167.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4CD86687EA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Nov 2005 07:45:19 +1100 (EST)
Date: Wed, 23 Nov 2005 13:13:45 -0200
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Dan Malek <dan@embeddededge.com>
Message-ID: <20051123151345.GC5313@logos.cnet>
References: <437E048B.2020605@dev.rtsoft.ru> <20051123125326.GB4526@logos.cnet>
	<24aa4090f558206fa04f9d584c590034@embeddededge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <24aa4090f558206fa04f9d584c590034@embeddededge.com>
Cc: Vitaly Bordug <vbordug@dev.rtsoft.ru>,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 8xx PCMCIA: support for MPC885ADS and MPC866ADS
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 23, 2005 at 03:22:40PM -0500, Dan Malek wrote:
> 
> On Nov 23, 2005, at 7:53 AM, Marcelo Tosatti wrote:
> 
> >Shouldnt you handle ioremap() failure? Most 85xx code written
> >by Kumar also does not.
> 
> And do what if it fails?  Chances are you don't have any
> way to report an error message or panic at this point.  In
> fact, there are a few silly tests like this where the
> failure tries to panic or print some message that will never
> be seen.  Fortunately, the code will never fail and we will
> never take such code paths.

OK! Was talking BS then.
