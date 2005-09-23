Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao05.cox.net (fed1rmmtao05.cox.net [68.230.241.34])
	by ozlabs.org (Postfix) with ESMTP id 4E5336839A
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 24 Sep 2005 03:17:20 +1000 (EST)
Date: Fri, 23 Sep 2005 10:17:12 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Roland Dreier <rolandd@cisco.com>
Message-ID: <20050923101712.F21055@cox.net>
References: <2005922203.92drttvd27WS9dXk@cisco.com>
	<2005922203.UPGbNSgrHKasoXYq@cisco.com>
	<20050923032949.GB10089@gate.ebshome.net>
	<52y85obanw.fsf@cisco.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <52y85obanw.fsf@cisco.com>;
	from rolandd@cisco.com on Thu, Sep 22, 2005 at 10:44:35PM -0700
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH 2/4] [PPC32] Add 440SPe support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 22, 2005 at 10:44:35PM -0700, Roland Dreier wrote:
>     Eugene> Roland, I recently added new field (.dcr_base) to this
>     Eugene> structure (as a preparation step for new EMAC driver),
>     Eugene> could you do this for 440SPe as well? It's not needed
>     Eugene> right now, but as soon as new EMAC driver is in, 440SPe
>     Eugene> will stop working.
> 
>     Eugene> I think you probably missed this part :)
> 
> Both fixed and pushed in a new git tree...

Can you rebase off of Eugene's tree and resend patches? For the moment
the new EMAC driver is the lynchpin in anything new PPC4xx.  I want
to hold off merging anything that involves current EMAC driver changes
until the new driver is in. In any case, nothing like this can go upstream
until after 2.6.14 is released. We are expecting the new EMAC driver to
be merged at that point.  If you have this stuff rebased from his tree
we can easily merge them post-EMAC merge.

-Matt
