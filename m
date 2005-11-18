Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AD0768761
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Nov 2005 01:46:22 +1100 (EST)
In-Reply-To: <1132311088.20016.88.camel@gaston>
References: <20051107160939.GD3839@smtp.west.cox.net>
	<1131380422.27347.72.camel@baythorne.infradead.org>
	<20051107165453.GA29111@lst.de>
	<1131382971.27347.79.camel@baythorne.infradead.org>
	<1132131116.28963.75.camel@baythorne.infradead.org>
	<17274.63508.501761.748278@cargo.ozlabs.ibm.com>
	<1132136755.21643.40.camel@hades.cambridge.redhat.com>
	<17277.10875.334722.856865@cargo.ozlabs.ibm.com>
	<3F990F6D-7A3F-47CA-938F-968593678895@kernel.crashing.org>
	<1132285818.20016.79.camel@gaston> <20051118082358.GA2309@lst.de>
	<1132311088.20016.88.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5534EC32-EE72-4019-A5D9-305F8348E4D9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Fri, 18 Nov 2005 08:46:49 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	David Woodhouse <dwmw2@infradead.org>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] Fix 8250 probe on ppc32
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 18, 2005, at 4:51 AM, Benjamin Herrenschmidt wrote:

> On Fri, 2005-11-18 at 09:23 +0100, Christoph Hellwig wrote:
>> On Fri, Nov 18, 2005 at 02:50:17PM +1100, Benjamin Herrenschmidt  
>> wrote:
>>> On Thu, 2005-11-17 at 21:26 -0600, Kumar Gala wrote:
>>>> Paul or BenH,
>>>>
>>>> Would you like to enlighten us on this ambitious rework?
>>>
>>> First, some better & more generic routines for translating addresses
>>> from the device-tree, and some more generic code for looking for
>>> standard serial port using the above routines, among others ...  
>>> also,
>>> set_preferred_console gets modified to use the previous list so  
>>> it can
>>> detect the ports more reliably, etc ....
>>
>> so as a start can we move the code to a place in arch/powerpc/ where
>> it can bee used by ppc32 _now_ because it fixes a real problem?  You
>> can add your encehancements whenever you get time to actually do it.
>
> My patch makes it ppc32 too :) udbg gets build on ppc32 along with  
> early
> console etc... all with the same code path as ppc64. I still need to
> test it on more hw and fix a few problems and hopefully will post it
> before the week-end is over.

How early on can we use udbg? I'd be interested to see how this is  
going to work out for 4xx/83xx/85xx w/built-in 8250's.

- kumar
