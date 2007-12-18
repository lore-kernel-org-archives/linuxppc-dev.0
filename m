Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 0FF90DDE9E
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 03:09:53 +1100 (EST)
Message-ID: <4767F0AD.5090908@freescale.com>
Date: Tue, 18 Dec 2007 10:09:17 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, galak@kernel.crashing.org,
	linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 1/3] 8xx: Analogue & Micro Adder875 board support.
References: <20071212225427.GA19027@loki.buserror.net>
	<20071217035706.GA3262@localhost.localdomain>
	<47669285.8010707@freescale.com>
	<20071218004329.GB9489@localhost.localdomain>
In-Reply-To: <20071218004329.GB9489@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Dec 17, 2007 at 09:15:17AM -0600, Scott Wood wrote:
>> Enh.  That can get icky as well, and the bootwrapper isn't necessarily 
>> even used for u-boot, and I'd rather not require it be used just for this.
> 
> So make the template in the u-boot form, and poke it as necessary from
> the redboot wrapper.

I'd rather not, given that I have limited access to a board with redboot 
to test on, and that it's just a cosmetic change.  Separate device trees 
are fine for now, and hopefully will motivate work on dtc templates.

-Scott
