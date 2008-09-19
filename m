Return-Path: <ncase@xes-inc.com>
Received: from xes-mad.com (xes-mad.com [216.165.139.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 145B7DDEFF
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Sep 2008 08:34:39 +1000 (EST)
Subject: Re: [PATCH] edac: mpc85xx: Add support for MPC8572
From: Nate Case <ncase@xes-inc.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <4DA3AC98-4FDC-441C-AFC4-F2E3558420A6@kernel.crashing.org>
References: <1221858771-14928-1-git-send-email-ncase@xes-inc.com>
	<4DA3AC98-4FDC-441C-AFC4-F2E3558420A6@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 19 Sep 2008 17:28:40 -0500
Message-Id: <1221863320.19971.156.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Kilkenny <akilkenny@xes-inc.com>,
	Dave Jiang <djiang@mvista.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-09-19 at 16:43 -0500, Kumar Gala wrote:
> I don't have any issue with this, but why are you marking the PCI  
> error interrupt as shared?
[snip]
> this I'm a bit more skeptical about.

The only one we really need to make shared is the memory controller
interrupt.  I'll drop it for the PCI and L2 interrupts in the next rev
of the patch.

> its fsl,mpc8572..  (we need to fix the others to match that convention  
> as its pretty standard for other device tree nodes)

I actually started out with "fsl,mpc8572-*" but then somehow convinced
myself I was wrong when I saw fsl,85xx in so many other places :)

Thanks for the feedback.  I'll correct these and re-submit.

-- 
Nate Case <ncase@xes-inc.com>
