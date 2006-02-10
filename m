Return-Path: <dwh@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "sabrina.ovro.caltech.edu",
	Issuer "sabrina.ovro.caltech.edu" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EEBB467B42
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 04:40:40 +1100 (EST)
Message-ID: <43ECCF7C.9070701@ovro.caltech.edu>
Date: Fri, 10 Feb 2006 09:38:04 -0800
From: David Hawkins <dwh@ovro.caltech.edu>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
Subject: Re: Yosemite/440EP 'issues' as a PCI target
References: <20060210173133.964B53525CC@atlas.denx.de>
In-Reply-To: <20060210173133.964B53525CC@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>Of course there is also the option of finding another
>>PowerPC that matches my requirements;
> 
> ...
> 
> MPC834x comes to mind. But I have to admit that we never tried  using
> this as a PCI device yet...
> 

Thanks Wolfgang, I'll take a look at the user manual.

Regarding PowerPC devices that can be (uselessly) configured
as PCI agents/targets/peripherals;

  - the Artesyn PMC board I got from eBay contains the
    IBM CPC700 bridge - it can never generate PCI interrupts
    as a target (non-monarch mode).

  - the MPC5200 PowerPC, can also be configured as a target,
    but will never generate PCI interrupts.

Gee, who knew. I didn't :)

Dave
