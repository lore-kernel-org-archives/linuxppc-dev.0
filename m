Return-Path: <b07421@freescale.com>
Date: Tue, 3 Jul 2007 13:29:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
Message-ID: <20070703182930.GA26688@ld0162-tx32.am.freescale.net>
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182796800.23775.51.camel@weaponx.rchland.ibm.com>
	<0FBD8D7C-1A60-4305-992C-5C28ECE41278@kernel.crashing.org>
	<1182804609.20939.5.camel@weaponx.rchland.ibm.com>
	<b75c4d9610522f1a45ed1e65c9a4a548@kernel.crashing.org>
	<1182864764.19501.7.camel@weaponx.rchland.ibm.com>
	<1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
	<20070626171811.GD31457@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070626171811.GD31457@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 10:18:11AM -0700, Mark A. Greer wrote:
> Actually, I wouldn't have a problem with getting rid of arch/ppc right
> now.  It won't really be lost, just git checkout your favorite tag that
> still has it.  It'll get rid of code people shouldn't be worrying about
> anymore anyway.
> 
> I realize, I'm probably the only one with this opinion so you don't have
> to tell me all the reasons I'm wrong. :)

Not at all -- it'd save me a lot of "#ifdef CONFIG_PPC_MERGE"s in my CPM
driver patches. :-)

-Scott
