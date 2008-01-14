Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 482C7DDE46
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 09:49:29 +1100 (EST)
Message-ID: <478BE6F2.4020207@freescale.com>
Date: Mon, 14 Jan 2008 16:49:22 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Bryan O'Donoghue" <bodonoghue@codehermit.ie>
Subject: Re: [PATCH 1/3] 8xx: Analogue & Micro Adder875 board support.
References: <20080111200705.GA696@loki.buserror.net>	
	<1200234372.3990.24.camel@neuromancer.mindspace>	
	<20080114152859.GA26907@ld0162-tx32.am.freescale.net>
	<1200350407.4061.19.camel@neuromancer.mindspace>
In-Reply-To: <1200350407.4061.19.camel@neuromancer.mindspace>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Bryan O'Donoghue wrote:
> Ah.
> 
> This explains eveything then.. there _is_ a magic image and I haven't
> been booting it !
> 
> Typical.
> 
> I'll give the 8xx-centric ucImage a go.

It is not 8xx centric; it is a compatibility layer for old, 
non-device-tree aware u-boots (regardless of what chip you're using).

> It occurs to me that this type of procedure should really be added to
> the Documentation... 
> 
> There's no mention of it in the Linux documentation, nor in the u-boot
> documentation and uncle Google was not informative for the types of
> searches I was doing....

Search for "device tree" in u-boot's README.

-Scott
