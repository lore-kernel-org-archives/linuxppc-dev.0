Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 49296DE06B
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jul 2008 00:59:53 +1000 (EST)
Message-ID: <4880AFDD.4030104@freescale.com>
Date: Fri, 18 Jul 2008 09:59:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware	helper
	for matching bus and codec drivers
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>	<20080714134930.GC25448@sirena.org.uk>	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>	<20080714171632.GH25448@sirena.org.uk>
	<20080718071720.GA2174@secretlab.ca>
In-Reply-To: <20080718071720.GA2174@secretlab.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:

> Okay, I've changed my mind.  :-)  I'll back off a bit from this extreme and
> call it:
> 
> sound/soc/fsl/soc-of-simple.c

That works for me.

And please don't forget to CC: me on any discussion involving sound/soc/fsl.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
