Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 071CEDDE09
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 06:16:15 +1100 (EST)
Subject: Re: [PATCH 2/3] mpc82xx: Embedded Planet EP8248E support
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <5898D87A-231D-4CCB-9538-808562F08D57@kernel.crashing.org>
References: <20071211212247.GB3620@loki.buserror.net>
	<EB293853-B27A-4B0E-AEEB-8D3F09E8F12D@kernel.crashing.org>
	<20071214155341.GB16269@ld0162-tx32.am.freescale.net>
	<5898D87A-231D-4CCB-9538-808562F08D57@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1199301353.7345.28.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 02 Jan 2008 13:15:53 -0600
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-12-14 at 10:28, Kumar Gala wrote:

> > Are there any tools to autoconvert (preferably without losing  
> > comments)?
> 
> Not sure of jon had a perl script or something.

No, I don't.  It's hard to tell what should conceptually
remain hex, and what might need to be decimalized.
Sure, hard lists of properties could be done and all...

One can do a "-I dts -O dts" and get it all converted
to /dts-v1/, but with comments dropped on the floor.

Sorry.

jdl
