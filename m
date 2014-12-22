Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E9541A05DA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Dec 2014 13:21:18 +1100 (AEDT)
Message-ID: <1419214877.20221.2.camel@ellerman.id.au>
Subject: Re: [PATCH] macintosh: therm_pm72: delete deprecated driver
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@the-dreams.de>
Date: Mon, 22 Dec 2014 13:21:17 +1100
In-Reply-To: <20141219162146.GA3632@katana>
References: <1415238358-2453-1-git-send-email-wsa@the-dreams.de>
 <1415240376.4925.2.camel@kernel.crashing.org>
 <20141106092551.GA1333@katana>
 <1415267404.4925.15.camel@kernel.crashing.org>
 <20141219162146.GA3632@katana>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-12-19 at 17:21 +0100, Wolfram Sang wrote:
> On Thu, Nov 06, 2014 at 08:50:04PM +1100, Benjamin Herrenschmidt wrote:
> > On Thu, 2014-11-06 at 10:25 +0100, Wolfram Sang wrote:
> > > On Thu, Nov 06, 2014 at 01:19:36PM +1100, Benjamin Herrenschmidt wrote:
> > > > On Thu, 2014-11-06 at 02:45 +0100, Wolfram Sang wrote:
> > > > > The new driver is around for more than 2 years now, so the old one can
> > > > > go. Getting rid of it helps the removal of the legacy .attach_adapter
> > > > > callback of the I2C subsystem.
> > > > > 
> > > > > Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> > > > 
> > > > Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > > 
> > > Thanks! I can take it via my I2C tree, but I'd think it makes more sense
> > > if you take it via ppc? What do you prefer?
> > 
> > Either works. These days Michael Ellerman handles the day to day
> > maintainance of the powerpc tree so it's his choice but if you need this
> > as a dependency on your subsequent API removal it's probably better that
> > you take it.
> 
> So, I haven't seen this coming in via ppc. I am going to send another
> pull request to Linus tomorrow and will include it unless somebody
> objects soon.

Sorry, communication break down between Ben & I. I'm happy for you to take it.

cheers
