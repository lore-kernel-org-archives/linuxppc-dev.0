Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CD958DE128
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jun 2008 08:19:29 +1000 (EST)
Message-ID: <4851A0EA.2090006@freescale.com>
Date: Thu, 12 Jun 2008 17:19:22 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Goodenough <david.goodenough@linkchoose.co.uk>
Subject: Re: Freescale MPC8321 support
References: <200806122225.33060.david.goodenough@linkchoose.co.uk>
In-Reply-To: <200806122225.33060.david.goodenough@linkchoose.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

David Goodenough wrote:
> This processor is described as an e300c2 core.  I found that e300c2
> is listed in the arch/powerpc/kernel/cputypes.c file.  Does this mean
> that it is supported, or is that just a place holder?

Yes, it is supported.

> If it is supported (as a core) what about the peripherals built into
> the MPC8321 are they likely to be supported?

The more commonly used ones should be.

> How about Flash support, or is this very board dependant?

Yes, flash (I assume you mean NOR) should work.  See the localbus nodes 
in existing device trees.

-Scott
