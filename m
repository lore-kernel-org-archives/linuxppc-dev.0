Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id 2A6D067A2F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Feb 2005 08:20:49 +1100 (EST)
Date: Wed, 23 Feb 2005 14:20:46 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Tom Rini <trini@kernel.crashing.org>, Shawn Jin <shawnxjin@gmail.com>,
	ppcembed <linuxppc-embedded@ozlabs.org>
Message-ID: <20050223142046.A13087@cox.net>
References: <c3d0340b05022310396240c8ac@mail.gmail.com>
	<20050223190123.GI345@smtp.west.cox.net>
	<20050223191247.GC6670@gate.ebshome.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050223191247.GC6670@gate.ebshome.net>;
	from ebs@ebshome.net on Wed, Feb 23, 2005 at 11:12:47AM -0800
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

On Wed, Feb 23, 2005 at 11:12:47AM -0800, Eugene Surovegin wrote:
> On Wed, Feb 23, 2005 at 12:01:23PM -0700, Tom Rini wrote:
> > > +#include "../../../../drivers/net/ibm_emac/ibm_emac_phy.h"
> > 
> > This will not work with O= for example.  The correct method is to modify
> > the Makefile with a CFLAGS_foo.o += -Idrivers/net/ibm_emac
> 
> I just tested and it does work even with O= :).
> 
> OTOH, I agree this is ugly hack (it was copied from ocotea.c, so blame 
> Matt for it :) and should be fixed correctly by moving those PHY 
> defines to some common include.

Ugh, yes...in my defense I clearly stated it was an "ugly hack". :)
 
-Matt
