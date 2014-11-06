Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 669CC1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Nov 2014 20:50:25 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B0CAB14008C
 for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2014 20:50:24 +1100 (AEDT)
Message-ID: <1415267404.4925.15.camel@kernel.crashing.org>
Subject: Re: [PATCH] macintosh: therm_pm72: delete deprecated driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Thu, 06 Nov 2014 20:50:04 +1100
In-Reply-To: <20141106092551.GA1333@katana>
References: <1415238358-2453-1-git-send-email-wsa@the-dreams.de>
 <1415240376.4925.2.camel@kernel.crashing.org>
 <20141106092551.GA1333@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Michael Ellerman <michaele@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-06 at 10:25 +0100, Wolfram Sang wrote:
> On Thu, Nov 06, 2014 at 01:19:36PM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2014-11-06 at 02:45 +0100, Wolfram Sang wrote:
> > > The new driver is around for more than 2 years now, so the old one can
> > > go. Getting rid of it helps the removal of the legacy .attach_adapter
> > > callback of the I2C subsystem.
> > > 
> > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > 
> > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Thanks! I can take it via my I2C tree, but I'd think it makes more sense
> if you take it via ppc? What do you prefer?

Either works. These days Michael Ellerman handles the day to day
maintainance of the powerpc tree so it's his choice but if you need this
as a dependency on your subsequent API removal it's probably better that
you take it.

Cheers,
Ben.
