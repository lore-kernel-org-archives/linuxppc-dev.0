Return-Path: <dalang@cs.ubc.ca>
Received: from mail-relay1.cs.ubc.ca (mail-relay1.cs.ubc.ca [142.103.6.79])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2A15679FC
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Mar 2006 02:18:53 +1100 (EST)
Date: Tue, 28 Mar 2006 06:37:39 -0800 (PST)
From: Dustin Lang <dalang@cs.ubc.ca>
To: Michal Purzynski <michal@rsbac.org>
Subject: Re: 2.6.16 does not boot on powerbook
In-Reply-To: <442925A8.6030004@rsbac.org>
Message-ID: <Pine.LNX.4.60.0603280630130.8520@tin.icics.ubc.ca>
References: <442925A8.6030004@rsbac.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> #
> # Platform support
> #
> CONFIG_PPC_MULTIPLATFORM=y
> # CONFIG_PPC_ISERIES is not set
> # CONFIG_EMBEDDED6xx is not set
> # CONFIG_APUS is not set
> # CONFIG_PPC_CHRP is not set
> # CONFIG_PPC_PMAC is not set

Could that be your problem?  (I've never used MULTIPLATFORM, maybe you set 
that intentionally; I've always used PPC_PMAC.)

Do you have ARCH=powerpc set?  It's possible that ARCH=ppc is broken...

2.6.16 works fine on my PowerBook 6,2.  When I patched up to 2.6.16 I 
found I had to go through the config process - some of the PowerMac 
options seem to have been turned off.  Maybe that was just me doing 
something wrong, or maybe some of the Kconfig defaults changed?

I'd suggest going through your config options again and making sure 
everything is the way you want it.

Cheers,
dstn.
