Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8FD76DDF58
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 07:08:42 +1000 (EST)
Message-ID: <4898C15E.3000900@freescale.com>
Date: Tue, 05 Aug 2008 16:08:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH add immr alias 2/4] powerpc: 5121: Add immr alias
	to	MPC5121 ADS device tree.
References: <1217967220-30557-1-git-send-email-jrigby@freescale.com>	<1217967220-30557-2-git-send-email-jrigby@freescale.com>
	<fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>
In-Reply-To: <fa686aa40808051405j7268c216j8e5b526d6ad526c9@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Is it not sufficient to search the tree for a node with the
> <chip>-immr compatible value?  I don't think this is the intended use
> case of aliases.

That get's really annoying in code that is meant to deal with multiple 
chips.  I don't think finding the network or serial node that 
corresponds to u-boot's enumeration is what it's meant for, either, but 
pretty much any alternative you can come up with has someone saying that 
it's not what *that* was meant for, either.

-Scott
