Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao01.cox.net (fed1rmmtao01.cox.net [68.230.241.38])
	by ozlabs.org (Postfix) with ESMTP id 4689F6830A
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Sep 2005 00:28:43 +1000 (EST)
Date: Mon, 19 Sep 2005 07:28:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Message-ID: <20050919072836.C25356@cox.net>
References: <004f01c5bd21$394104e0$dbe5fed4@scsad.scs.ch>
	<1127139816.3211.4.camel@windu.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1127139816.3211.4.camel@windu.rchland.ibm.com>;
	from jwboyer@jdub.homelinux.org on Mon, Sep 19, 2005 at
	09:23:36AM -0500
Cc: Peter Fercher <peter.fercher@scs.ch>,
	'linux-ppc-embedded' <linuxppc-embedded@ozlabs.org>
Subject: Re: emac driver broken in 2.6.12.2 ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2005 at 09:23:36AM -0500, Josh Boyer wrote:
> On Mon, 2005-09-19 at 15:51 +0200, Peter Fercher wrote:
> > I think that this MAC addresses are crap (sorry if not formulated clearly
> > enough for you ;)
> > am I wrong ?
> 
> No, you're not wrong.  My brain just didn't parse that as a problem with
> the emac code itself.
> 
> Anyway, I think David and Stefan have pointed you in the right
> direction.

Yep, he's got to configure the driver properly for his platform.

-Matt
