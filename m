Return-Path: <Bruce_Leonard@selinc.com>
Received: from duster.selinc.com (duster.selinc.com [74.117.214.140])
 by ozlabs.org (Postfix) with ESMTP id B9D8E1007D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 06:50:05 +1100 (EST)
In-Reply-To: <4F216C25.6000303@aimvalley.nl>
References: <OF74786861.90D91C05-ON8825798F.0083A71E-88257990.000118E7@selinc.com>
 <4F2004B1.5030607@aimvalley.nl>
 <OF248EC14B.3E5BA3A6-ON88257990.006C779B-88257990.006CE971@selinc.com>
 <4F216C25.6000303@aimvalley.nl>
To: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
Subject: Re: FSL SPI driver question
Message-ID: <OF144DE79D.27C5CEDA-ON88257991.006C677F-88257991.006CF2C1@selinc.com>
From: Bruce_Leonard@selinc.com
Date: Thu, 26 Jan 2012 11:49:59 -0800
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Norbert,

> 
> ok, then I don't know.
> 
> I doubt this is a spidev or FSP SPI driver problem though.
> 
> Questions like:
> 
> Could it be a HW problem ?
> Is the correct SPI mode used ?
> Does it work in u-boot ?
> 
> Come to mind in a situation like this.
> 

Thanks for the suggestions.  I finally found it in the wee hours this 
morning, and it was operator error.  The CY14 by default powers up in the 
write protect state and from the factory is erased to all zeros.  So my 
writes and subsequent reads appeared to fail by the "fact" that I could 
never read what I wrote.  Guess I need better reading glasses in my old 
age :-/

Anyway, I'm happily up and talking using the Freescale SPI driver and 
spidev.  Thanks for the help and sorry for the noise on the list.

Bruce
