Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 535692C0092
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Aug 2013 07:04:24 +1000 (EST)
Message-ID: <1375477449.15999.20.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ben Hutchings <ben@decadent.org.uk>
Date: Sat, 03 Aug 2013 07:04:09 +1000
In-Reply-To: <1375477013.32254.22.camel@deadeye.wl.decadent.org.uk>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local> <1375447861.15999.1.camel@pasglop>
 <1375454871.3852.27.camel@thor.local> <1375476455.15999.13.camel@pasglop>
 <1375477013.32254.22.camel@deadeye.wl.decadent.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Jan Engelhardt <jengelh@inai.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 22:56 +0200, Ben Hutchings wrote:
> > Yes. Do you have all the windfarm modules loaded ? What about
> > i2c-powermac ? (It's typical that the latter is missed, I think it
> > doesn't auto-load, which we never fixed, we used to request distros
> to
> > just built it in)
> 
> We built it as a module in 3.2 and we still do.  The regression
> apparently occurred between 3.8 and 3.9.

Interesting. Maybe the old MODULE_ALIAS statement in there no longer
work....

Ben.
