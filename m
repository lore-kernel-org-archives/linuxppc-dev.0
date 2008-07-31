Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AFC37DE370
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 08:52:16 +1000 (EST)
Message-ID: <4892421B.3020704@freescale.com>
Date: Thu, 31 Jul 2008 17:52:11 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix whitespace merge in mpc8641 hpcn device tree
References: <Pine.LNX.4.64.0807311709530.10954@blarg.am.freescale.net>	<48923A43.9040901@freescale.com>
	<BF7C9A64-AABC-4624-8282-4BAC2D970009@kernel.crashing.org>
In-Reply-To: <BF7C9A64-AABC-4624-8282-4BAC2D970009@kernel.crashing.org>
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

Kumar Gala wrote:
> np.  It would be nice to see dtc warn about it, but that would probably 
> be a bit difficult.

One thing that macros may bring besides clarity and elimination of 
redundancy is the ability to put some semantic checks in the macro 
itself (rather than hardcoding it into dtc).  At the very least, this 
particular bug would show up as the wrong number of arguments to a macro.

-Scott
