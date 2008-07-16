Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id CD7CBDDF6E
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 08:15:59 +1000 (EST)
Date: Wed, 16 Jul 2008 18:15:56 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [PATCH] Fix wrong 'no interrupt' handling in of_i2c
Message-ID: <20080716181556.2974a1a8@lappy.seanm.ca>
In-Reply-To: <fa686aa40806281216v71f33a70n67eca1c1e69417d8@mail.gmail.com>
References: <20080628183141.15298.2758.stgit@octopus.labnet.pengutronix.de>
	<fa686aa40806281216v71f33a70n67eca1c1e69417d8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Wolfram Sang <w.sang@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 28 Jun 2008 13:16:16 -0600
"Grant Likely" <grant.likely@secretlab.ca> wrote:

> On Sat, Jun 28, 2008 at 12:31 PM, Wolfram Sang
> <w.sang@pengutronix.de> wrote:
> > If an I2C device node does not specify an interrupt, the .irq
> > member of the board_info struct was set to -1. This caused crashes
> > on following irq_dispose_mappings. Leave it NO_IRQ as returned from
> > irq_of_parse_and_map. (Suggesting -1 as 'i2c-no-irq' used to be a
> > bug in linux/i2c.h.)
> >
> > Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>
> 

I just hit this while trying to get the at24 driver working. So:

Acked-by: Sean MacLennan <smaclennan@pikatech.com>

Cheers,
   Sean
