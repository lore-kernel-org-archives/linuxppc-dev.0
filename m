Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97A13DDE19
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:52:44 +1000 (EST)
Message-ID: <469E6F85.1070801@freescale.com>
Date: Wed, 18 Jul 2007 14:52:37 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 06/61] 8xx: Don't call non-existent Soft_emulate_8xx from
	SoftwareEmulation.
References: <20070718013302.GE15238@ld0162-tx32.am.freescale.net>
	<3F44085F-8A67-4134-95A3-39897F2A84FD@kernel.crashing.org>
	<469E3E3F.8050302@freescale.com>
	<71A8ECC1-931F-42AE-98B1-A4B90E4B5980@kernel.crashing.org>
In-Reply-To: <71A8ECC1-931F-42AE-98B1-A4B90E4B5980@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> I don't see any reason to break people that might not have updated  
> their toolchains.

Full math emulation is still an option...

>  There is no reason for us to drop a feature like  
> this w/o some additional warning.

...as is arch/ppc, whose remaining life expectancy can serve as the 
warning period.

-Scott
