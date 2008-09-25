Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 219CCDE10F
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Sep 2008 04:52:34 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	m8PIqU9l004873
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 11:52:30 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m8PIqKos028646
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 13:52:20 -0500 (CDT)
Date: Thu, 25 Sep 2008 13:52:19 -0500
From: Scott Wood <scottwood@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC/PATCH] powerpc: Cleanup 32/64 bit syscall int sign ext.
Message-ID: <20080925185219.GB5230@ld0162-tx32.am.freescale.net>
References: <1222326096.8277.178.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1222326096.8277.178.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 25, 2008 at 05:01:36PM +1000, Benjamin Herrenschmidt wrote:
> +#define XGLUE(a,b) a##b
> +#define GLUE(a,b) XGLUE(a,b)

GLUE() doesn't appear to be used.

-Scott
