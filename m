Return-Path: <kim.phillips@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFE6CDDDF3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Jan 2008 04:52:51 +1100 (EST)
Date: Tue, 29 Jan 2008 11:43:10 -0600
From: Kim Phillips <kim.phillips@freescale.com>
To: Steven Hein <ssh@sgi.com>
Subject: Re: Configuring Freecale ucc_geth without a PHY
Message-Id: <20080129114310.3109caaa.kim.phillips@freescale.com>
In-Reply-To: <479F5D9B.8040403@sgi.com>
References: <479F5D9B.8040403@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 29 Jan 2008 11:08:43 -0600
Steven Hein <ssh@sgi.com> wrote:

> Hi all,
> 
> I have a custom board with an MPC8358 (our board is based
> off of the MPC8360E-MDS development board) that has its eth's
> directly connected (GMII) to a Broadcom network switch
> part on the same board, with no PHYs between them.
> We've have been using a 2.6.16.18 kernel (from TimeSys) up
> until now, and I hacked in some crude support for no-phy
> configs forced to 100Mbit and 1Gbit speeds.   Now I'm
> moving to 2.6.22 (with 8360 the patches from bitshrine.org),
> and I'm trying to understand how I should do this with
> device trees, the new PHY infrastructure, etc.   Has anyone
> else needed this support?   Does anyone have any suggestions
> as to how to tackle it?

check out the "fixed-link" property and associated code.  This
implementation came about after 2.6.22 though (it's commit-ish
v2.6.23-10096-ga21e282).

Kim
