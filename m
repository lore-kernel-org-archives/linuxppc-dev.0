Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id EA5CB67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 09:51:59 +1100 (EST)
In-Reply-To: <20050316221402.GA8345@smtp.west.cox.net>
References: <20050316221402.GA8345@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <97927672280934c417f3e8fceb7a144b@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 16 Mar 2005 16:52:00 -0600
To: "Tom Rini" <trini@kernel.crashing.org>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I dont have either of these readily available at this point.

If you dont mind running it through when you get a chance.  However, is=20=

this going to test anything but FP?

- kumar

On Mar 16, 2005, at 4:14 PM, Tom Rini wrote:

> On Wed, Mar 16, 2005 at 01:22:48AM -0600, Kumar Gala wrote:
>
> > Jason,
>  >
> > Is it possible to make this against a newer tree (like a current bk
> > pull).=A0 The patch doesn't apply cleanly against head.S, which I'm
> > guessing is due to the SPRN changes pushed upstream recently.
>  >
> > If I can apply it cleanly, I will get it pushed upstream.
>
> Can one of you run say LTP on a classic box, just as a sanity test
>  before pushing?=A0 If not, lemme know and I'll do it :)
>
> --=20
> Tom Rini
>  http://gate.crashing.org/~trini/
