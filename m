Return-Path: <glikely@secretlab.ca>
Received: from hs-out-0708.google.com (hs-out-0708.google.com [64.233.178.240])
	by ozlabs.org (Postfix) with ESMTP id AAED4DE277
	for <linuxppc-dev@ozlabs.org>; Sun, 25 May 2008 03:33:37 +1000 (EST)
Received: by hs-out-0708.google.com with SMTP id z77so679547hsz.9
	for <linuxppc-dev@ozlabs.org>; Sat, 24 May 2008 10:33:35 -0700 (PDT)
Message-ID: <fa686aa40805241033x128c30b0v826717cc879a712e@mail.gmail.com>
Date: Sat, 24 May 2008 11:33:35 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Jochen Friedrich" <jochen@scram.de>
Subject: Re: [PATCH 3/4] spi: Add OF binding support for SPI busses
In-Reply-To: <48384D13.6010608@scram.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080516193054.28030.35126.stgit@trillian.secretlab.ca>
	<20080516193613.28030.13950.stgit@trillian.secretlab.ca>
	<20080521151928.GA28857@polina.dev.rtsoft.ru>
	<200805221905.32288.david-b@pacbell.net>
	<fa686aa40805232326w35f455d1s274899160d47eccb@mail.gmail.com>
	<fa686aa40805240950ocd16b97y308a54c68efa28ef@mail.gmail.com>
	<48384D13.6010608@scram.de>
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

On Sat, May 24, 2008 at 11:14 AM, Jochen Friedrich <jochen@scram.de> wrote:
> Grant Likely schrieb:
>> On Sat, May 24, 2008 at 12:26 AM, Grant Likely
>> <grant.likely@secretlab.ca> wrote:
>>> On Thu, May 22, 2008 at 8:05 PM, David Brownell <david-b@pacbell.net> wrote:
>>>> On Wednesday 21 May 2008, Anton Vorontsov wrote:
>>>>>> +++ b/drivers/spi/spi_of.c
>>>>> I think better placement for this is drivers/of, no?
>>>> Yes please.
>>> Okay, I wasn't sure.  Will do.
>>
>> I'm having second thoughts about this.  I think this code is more SPI
>> centric than it is OF centric.  ie. it is usable by all spi masters in
>> an OF enabled system, but it is not usable by all OF devices in an SPI
>> enabled system.  Or, in other words; it adds OF support to SPI, not
>> the other way around.  I think drivers/spi is the right place for this
>> to live.
>
> Isn't the same true for drivers/of/gpio.c or drivers/of/of_i2c.c, as well?

I would argue 'yes!'

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
