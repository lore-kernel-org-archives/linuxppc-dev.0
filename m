Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 15089B6FC4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Apr 2012 17:42:03 +1000 (EST)
In-Reply-To: <1335237195.24897.0.camel@pasglop>
References: <1335220202-32533-1-git-send-email-grant.likely@secretlab.ca>	
 <1335220202-32533-2-git-send-email-grant.likely@secretlab.ca>
 <1335237195.24897.0.camel@pasglop>
Subject: Re: [PATCH v2 1/2] powerpc/8xx: Fix NR_IRQ bugs and refactor 8xx
 interrupt controller
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <OF4123672B.F86C969F-ONC12579EA.002A2C1F-C12579EA.002A48C2@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Tue, 24 Apr 2012 09:41:51 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote on 2012/04/24 05:13:15:
>
> On Mon, 2012-04-23 at 16:30 -0600, Grant Likely wrote:
> > The mpc8xx driver uses a reference to NR_IRQS that is buggy.  It uses
> > NR_IRQs for the array size of the ppc_cached_irq_mask bitmap, but
> > NR_IRQs could be smaller than the number of hardware irqs that
> > ppc_cached_irq_mask tracks.
>
> Joakim, any chance you can test this ASAP ? :-)

Sorry, but no.  We have not moved our 8xx boards to 3.x as it in maintenance
and takes too much space.
