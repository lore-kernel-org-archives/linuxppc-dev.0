Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id A1B2367A6E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 06:12:52 +1100 (EST)
Date: Wed, 23 Feb 2005 11:12:47 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050223191247.GC6670@gate.ebshome.net>
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
	<20050223190123.GI345@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050223190123.GI345@smtp.west.cox.net>
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] Ebony's UBoot awareness
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Feb 23, 2005 at 12:01:23PM -0700, Tom Rini wrote:
> > +#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
> 
> This will not work with O= for example.  The correct method is to modify
> the Makefile with a CFLAGS_foo.o += -Idrivers/net/ibm_emac

I just tested and it does work even with O= :).

OTOH, I agree this is ugly hack (it was copied from ocotea.c, so blame 
Matt for it :) and should be fixed correctly by moving those PHY 
defines to some common include.

--
Eugene
