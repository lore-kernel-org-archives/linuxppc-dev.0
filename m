Return-Path: <weo@reccoware.de>
Received: from bes.recconet.de (bes.recconet.de [87.106.167.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9272FDDDF3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 05:00:20 +1100 (EST)
Subject: Re: [PATCH v3] powerpc: Specify GPIO number base for controller in DT
From: Wolfgang Ocker <weo@reccoware.de>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <fa686aa40810241012o57e85215i9778efc342250137@mail.gmail.com>
References: <1224764850.4082.54.camel@galileo.recco.de>
	<D6AED5C1-6936-48BB-8D0F-98471C6841B0@kernel.crashing.org>
	<1224773378.4082.64.camel@galileo.recco.de>
	<200810232013.00539.sr@denx.de>
	<20081024165428.GC14350@oksana.dev.rtsoft.ru>
	<fa686aa40810241012o57e85215i9778efc342250137@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 24 Oct 2008 20:00:12 +0200
Message-Id: <1224871212.4039.6.camel@galileo.recco.de>
Mime-Version: 1.0
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-10-24 at 11:12 -0600, Grant Likely wrote:
> On Fri, Oct 24, 2008 at 10:54 AM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Thu, Oct 23, 2008 at 08:13:00PM +0200, Stefan Roese wrote:
> >> On Thursday 23 October 2008, Wolfgang Ocker wrote:
> >> > The GPIOLIB allows the specification of a base gpio number for a
> >> > controller. That is not possible using OF. Instead, free gpio numbers
> >> > are assigned.
> >> >
> >> > In order to allow static, predefined gpio numbers, a base property in
> >> > the gpio controller node specifies the first gpio number.
> >> >
> >> > v2, v3: added/improved description of base property in doc
> >>
> >> These version descriptions are better placed below the "---" line. And you
> >> should remove the "Re: " from the subject line. Other than this:
> >>
> >> Acked-by: Stefan Roese <sr@denx.de>

> Yeah, I don't like this patch either.  GPIO numbering is a Linux
> internal detail and has no bearing on the hardware description.  If
> you need to know what a particular gpio number is then it should be
> resolved by finding the device tree node; not by trying to fix a GPIO
> controller to a particular number.

Okay, now I think I understand.

I'll try to solve the chip select pin addressing in the spi driver
differently. Thank you guys!

Wolfgang 
