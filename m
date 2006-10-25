Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F2B6167C94
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 00:44:01 +1000 (EST)
Message-ID: <453F7832.2020305@genesi-usa.com>
Date: Wed, 25 Oct 2006 16:44:02 +0200
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
References: <453771E5.4090808@bplan-gmbh.de>	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>	<453884F5.4000804@bplan-gmbh.de>	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>	<453B6A84.3050209@bplan-gmbh.de>	<1161585371.10524.444.camel@localhost.localdomain>	<453CD615.4050401@genesi-usa.com>	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>	<453E34FB.3030209@genesi-usa.com>
	<17726.39780.732843.150044@cargo.ozlabs.ibm.com>
In-Reply-To: <17726.39780.732843.150044@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It supports the original processors, G3, G4 etc. as well. Maybe not
the 601? I'm not sure. All the PowerPC ISA Books are in there and
information only seems to have been ADDED (or moved to another
book or been given a new book).

If a processor is not supported it was probably designed and
end-of-lined well before they made the original "Book" specs :D

Have you even looked at it? Even the dumb 'evolution' picture
on Power.org's site makes this quite, quite clear. Most of the
spec is identical, to the letter, over vast amounts of pages.
There are change bars in front of everything that changed and
those that have; it seems they are just lifted and reworked
from Freescale's AltiVec/SPE documentation, reworded in Book E
so you can have a Book E with AltiVec, or has it's own new
book (VLE, which is an IBM-ified copy of the e200 Core
Reference Manual Addendum)

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations

Paul Mackerras wrote:
> Matt Sealey writes:
> 
>> http://www.power.org/news/articles/new_brand/#isa
>>
>> I'm talking about the one they consolidated from all the different specs
>> Freescale, AMCC and IBM had about what makes a PowerPC processor. Since
>> POWER is part of it and it's all Power.org now.. they seem to have changed
>> the name.
> 
> So, are you proposing we drop support for all the PowerPC processors
> that don't conform to the recently-published V2.03 ISA?  You don't
> want 6xx, 7xx, 7xxx, 52xx, etc. supported any more? :)  (joke :)
> 
> Seriously, the v2.03 ISA covers only IBM's latest POWER processors
> (i.e. not POWER3, POWER4, or even POWER5), and Book E processors.  We
> support a lot more than that.
> 
> Paul.
