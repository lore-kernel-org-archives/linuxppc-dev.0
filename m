Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 28E1267A46
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Mar 2005 03:03:38 +1100 (EST)
Date: Thu, 10 Mar 2005 09:03:27 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Gerhard Jaeger <g.jaeger@sysgo.com>
Message-ID: <20050310090327.A27661@cox.net>
References: <0007F077BB3476449151699150E8FEA205928C@exchange.tsi-telsys.com>
	<200503100837.08717.g.jaeger@sysgo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200503100837.08717.g.jaeger@sysgo.com>;
	from g.jaeger@sysgo.com on Thu, Mar 10, 2005 at 08:37:08AM +0100
Cc: Sanjay Bajaj <sbajaj@tsi-telsys.com>, linuxppc-embedded@ozlabs.org
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

On Thu, Mar 10, 2005 at 08:37:08AM +0100, Gerhard Jaeger wrote:
> On Wednesday 09 March 2005 18:11, Sanjay Bajaj wrote:
> > Has anybody used PPC 440GX with NS DP83865 phy? If you have or have any
> > information to set it up, please share. 
> > 
> We're using this PHY on a custom 440GX board. Connected via GMII!
> After setting up the RGMII bridge correctly (see manual), you also have to
> tweak the EMAC driver. I have sent a patch (which has been rejected) a few
> weeks ago to the list which changes the setup procedure of the EMAC to work
> with a DP83865 PHY. THe current implementation will not work.

FWIW, I did go back and see the patch from 22 October in my mbox.  It's
not rejected...just missed amongst a lot of other things. If things
are quiet, it's best to ping in case somebody missed your patch.

Thanks,
Matt
