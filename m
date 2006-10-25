Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E99CD68018
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Oct 2006 00:50:19 +1000 (EST)
In-Reply-To: <453F7832.2020305@genesi-usa.com>
References: <453771E5.4090808@bplan-gmbh.de>	<77AD49CA-69CB-4ADA-B8F3-3BC3A066BCF9@kernel.crashing.org>	<453884F5.4000804@bplan-gmbh.de>	<122A4E06-B8A6-4256-B96E-3811EA93EA25@kernel.crashing.org>	<453B6A84.3050209@bplan-gmbh.de>	<1161585371.10524.444.camel@localhost.localdomain>	<453CD615.4050401@genesi-usa.com>	<17725.18623.768768.438157@cargo.ozlabs.ibm.com>	<453E34FB.3030209@genesi-usa.com>
	<17726.39780.732843.150044@cargo.ozlabs.ibm.com>
	<453F7832.2020305@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0728ABEB-7D51-4694-9AB9-EE631DE8453E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Date: Wed, 25 Oct 2006 09:50:11 -0500
To: Matt Sealey <matt@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 25, 2006, at 9:44 AM, Matt Sealey wrote:

> It supports the original processors, G3, G4 etc. as well. Maybe not
> the 601? I'm not sure. All the PowerPC ISA Books are in there and
> information only seems to have been ADDED (or moved to another
> book or been given a new book).
>
> If a processor is not supported it was probably designed and
> end-of-lined well before they made the original "Book" specs :D
>
> Have you even looked at it? Even the dumb 'evolution' picture
> on Power.org's site makes this quite, quite clear. Most of the
> spec is identical, to the letter, over vast amounts of pages.
> There are change bars in front of everything that changed and
> those that have; it seems they are just lifted and reworked
> from Freescale's AltiVec/SPE documentation, reworded in Book E
> so you can have a Book E with AltiVec, or has it's own new
> book (VLE, which is an IBM-ified copy of the e200 Core
> Reference Manual Addendum)

There is far more new in the 2.03 spec than just merging of various  
existing specs as you are stating.  Please be more careful with  
general statements like this.  The Book III-E has some significant  
changes from Book-E 1.0.

- k
