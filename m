Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 2B84667A6E
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  5 Mar 2005 03:44:19 +1100 (EST)
In-Reply-To: <20050304093515.A4471@cox.net>
References: <20050304093515.A4471@cox.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <c31ade343817d01390084334633fd898@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 4 Mar 2005 10:44:14 -0600
To: "Matt Porter" <mporter@kernel.crashing.org>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [2/2] Device driver part.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Fair enough, we might actually have multiple watchdogs on some of are=20
parts when the integrate system logic w/its own watchdog.  Makes sense.=20=

  Lets leave it a config option then.

- kumar

On Mar 4, 2005, at 10:35 AM, Matt Porter wrote:

> On Fri, Mar 04, 2005 at 10:02:40AM -0600, Kumar Gala wrote:
>  > Matt,
>  >
> > Do you think this really needs a config option?=A0 Should it not be=A0=

> > sufficient that if you enable watchdog you get this functionality =
on=A0
> > 4xx/e500?
>
> I see the 8xx example, however, there may be a case where somebody
>  wants to use another hardware watchdog mechanism.=A0 In that case,
>  they probably don't want this facility automagically being enabled.
> I think having the option can't hurt.
>
> -Matt
