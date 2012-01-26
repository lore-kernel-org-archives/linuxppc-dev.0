Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7C6651007D2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2012 02:07:23 +1100 (EST)
Message-ID: <4F216C25.6000303@aimvalley.nl>
Date: Thu, 26 Jan 2012 16:07:17 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Bruce_Leonard@selinc.com
Subject: Re: FSL SPI driver question
References: <OF74786861.90D91C05-ON8825798F.0083A71E-88257990.000118E7@selinc.com>
 <4F2004B1.5030607@aimvalley.nl>
 <OF248EC14B.3E5BA3A6-ON88257990.006C779B-88257990.006CE971@selinc.com>
In-Reply-To: <OF248EC14B.3E5BA3A6-ON88257990.006C779B-88257990.006CE971@selinc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Bruce,


On 01/25/12 20:49, Bruce_Leonard@selinc.com wrote:
.
.
.
> Thanks for the reply.  Yes I did find spidev_fdx.c and in fact copied it
> for my tests.  I still see SPICLK active only during the time the 8308 is
> sending data (read cmd + address).  Nothing happens with the clock after
> that when the NvRAM is ready to send data.
>
> Bruce
>


ok, then I don't know.

I doubt this is a spidev or FSP SPI driver problem though.

Questions like:

Could it be a HW problem ?
Is the correct SPI mode used ?
Does it work in u-boot ?

Come to mind in a situation like this.


Norbert.
