Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id ED7F4DDFCB
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 03:15:30 +1000 (EST)
Message-ID: <48384D13.6010608@scram.de>
Date: Sat, 24 May 2008 19:14:59 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>	<20080521151928.GA28857@polina.dev.rtsoft.ru>	<200805221905.32288.david-b@pacbell.net>	<fa686aa40805232326w35f455d1s274899160d47eccb@mail.gmail.com>
	<fa686aa40805240950ocd16b97y308a54c68efa28ef@mail.gmail.com>
In-Reply-To: <fa686aa40805240950ocd16b97y308a54c68efa28ef@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: David Brownell <david-b@pacbell.net>, linuxppc-dev@ozlabs.org,
	fabrizio.garetto@gmail.com, linux-kernel@vger.kernel.org,
	spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely schrieb:
> On Sat, May 24, 2008 at 12:26 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
>> On Thu, May 22, 2008 at 8:05 PM, David Brownell <david-b@pacbell.net> wrote:
>>> On Wednesday 21 May 2008, Anton Vorontsov wrote:
>>>>> +++ b/drivers/spi/spi_of.c
>>>> I think better placement for this is drivers/of, no?
>>> Yes please.
>> Okay, I wasn't sure.  Will do.
> 
> I'm having second thoughts about this.  I think this code is more SPI
> centric than it is OF centric.  ie. it is usable by all spi masters in
> an OF enabled system, but it is not usable by all OF devices in an SPI
> enabled system.  Or, in other words; it adds OF support to SPI, not
> the other way around.  I think drivers/spi is the right place for this
> to live.

Isn't the same true for drivers/of/gpio.c or drivers/of/of_i2c.c, as well?

Thanks,
Jochen
