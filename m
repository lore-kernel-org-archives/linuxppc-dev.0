Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 24E7767A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:24:08 +1100 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: Matt Porter <mporter@kernel.crashing.org>
Date: Thu, 10 Mar 2005 17:24:00 +0100
References: <0007F077BB3476449151699150E8FEA205928C@exchange.tsi-telsys.com>
	<200503100837.08717.g.jaeger@sysgo.com>
	<20050310090327.A27661@cox.net>
In-Reply-To: <20050310090327.A27661@cox.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200503101724.00567.g.jaeger@sysgo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: PPC 440GX with NS DP83865 phy
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 10 March 2005 17:03, Matt Porter wrote:
> On Thu, Mar 10, 2005 at 08:37:08AM +0100, Gerhard Jaeger wrote:
> > On Wednesday 09 March 2005 18:11, Sanjay Bajaj wrote:
> > > Has anybody used PPC 440GX with NS DP83865 phy? If you have or have any
> > > information to set it up, please share. 
> > > 
> > We're using this PHY on a custom 440GX board. Connected via GMII!
> > After setting up the RGMII bridge correctly (see manual), you also have to
> > tweak the EMAC driver. I have sent a patch (which has been rejected) a few
> > weeks ago to the list which changes the setup procedure of the EMAC to work
> > with a DP83865 PHY. THe current implementation will not work.
> 
> FWIW, I did go back and see the patch from 22 October in my mbox.  It's
> not rejected...just missed amongst a lot of other things. If things
> are quiet, it's best to ping in case somebody missed your patch.
> 
Matt - no problem. The answer in october, I got from Eugene was, that
you guys are working on a "new" EMAC driver with NAPI support and I also
had a running setup - so - no worries ;)

Gerhard
