Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CBAE667A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 19 Mar 2005 03:06:39 +1100 (EST)
In-Reply-To: <20050316231800.GD8345@smtp.west.cox.net>
References: <20050316231800.GD8345@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <d0e9907f9780a7fce59b3f69af6ece99@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 18 Mar 2005 10:06:31 -0600
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded Linux list <linuxppc-embedded@ozlabs.org>
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

Jason,

Can you build your patch for the lopec_defconfig and fix the errors=20
associated with enabling altivec.

Looks like you need to include asm/offset.h & asm/page.h in vector.S,=20
however there is another build error after that.

Resend, with a fix.

thanks

- kumar

On Mar 16, 2005, at 5:18 PM, Tom Rini wrote:

> On Wed, Mar 16, 2005 at 04:52:00PM -0600, Kumar Gala wrote:
>
> > I dont have either of these readily available at this point.
>  >
> > If you dont mind running it through when you get a chance.=A0 =
However,=20
> is
> > this going to test anything but FP?
>
> It's more of a funkiness test, just in case.
>
> --=20
> Tom Rini
>  http://gate.crashing.org/~trini/
