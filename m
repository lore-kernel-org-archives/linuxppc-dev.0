Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9D875DE4FA
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jan 2009 09:38:10 +1100 (EST)
Message-ID: <49652ECC.70309@freescale.com>
Date: Wed, 07 Jan 2009 16:38:04 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 2/5] powerpc: Generic device tree for all AmigaOne boards
References: <20090107135457.234150@gmx.net> <20090107140132.140980@gmx.net>	
	<fa686aa40901070841o3ede1d56tf5f69c33523513f4@mail.gmail.com>	
	<20090107221028.GA18669@ld0162-tx32.am.freescale.net>	
	<fa686aa40901071421w6c4aa48eyd869eb952373a74d@mail.gmail.com>	
	<49652B79.5010502@freescale.com>
	<fa686aa40901071436x35fb6c6ar3f711c53d7edf2bc@mail.gmail.com>
In-Reply-To: <fa686aa40901071436x35fb6c6ar3f711c53d7edf2bc@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On Wed, Jan 7, 2009 at 3:23 PM, Scott Wood <scottwood@freescale.com> wrote:
>> It doesn't seem any more likely to introduce a fault by specifying the
>> interrupt controller in one place than in many places.
> 
> We do the same thing with #address-cells and #size-cells for the same
> reason.  You can get away with leaving them out; but being explicit is
> more clear.

That's different -- the defaults for #address-cells and #size-cells are 
abitrary constants (2 and 1, respectively), not merely something that 
was defined higher in the hierarchy.

-Scott
