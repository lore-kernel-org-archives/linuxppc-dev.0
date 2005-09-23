Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao04.cox.net (fed1rmmtao04.cox.net [68.230.241.35])
	by ozlabs.org (Postfix) with ESMTP id 53BFD683B9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 06:36:54 +1000 (EST)
Date: Fri, 23 Sep 2005 13:36:51 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923133651.M21055@cox.net>
References: <2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<2005922203.qtfGFmWm3E8jkhq1@cisco.com>
	<20050923032236.GA10089@gate.ebshome.net>
	<52irwscq49.fsf@cisco.com> <20050923101158.E21055@cox.net>
	<52d5mza5wa.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52d5mza5wa.fsf@cisco.com>;
	from rolandd@cisco.com on Fri, Sep 23, 2005 at 01:25:09PM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 3/4] [PPC32] ibm_emac: Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Sep 23, 2005 at 01:25:09PM -0700, Roland Dreier wrote:
>     Matt> We're working on this. It's not exactly that simple since
>     Matt> Jeff established that all net drivers must enter through the
>     Matt> netdev tree. I expect it can get merged post 2.6.14 if all
>     Matt> goes well.
> 
> Jeff may want all net drivers to go through his tree, but with all due
> respect to him, there's no law that says it has to be so.
> 
> cf. Linus's recent post: http://lkml.org/lkml/2005/9/22/220
 
Yep, one step at a time.  There's no rush for today or tomorrow...
nothing like this is going into the tree until post 2.6.14 anyway.

-Matt
