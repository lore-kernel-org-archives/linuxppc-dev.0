Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2E1E0DDE42
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Apr 2007 03:36:48 +1000 (EST)
Date: Fri, 13 Apr 2007 12:36:39 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v2] powerpc: document max-speed and interface-type
	properties
Message-Id: <20070413123639.6485797b.kim.phillips@freescale.com>
In-Reply-To: <B273DC06-E4DF-4FF5-88E8-2E6C634C98DA@kernel.crashing.org>
References: <20070413012542.343eb848.kim.phillips@freescale.com>
	<B273DC06-E4DF-4FF5-88E8-2E6C634C98DA@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Apr 2007 12:00:32 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> On Apr 13, 2007, at 1:25 AM, Kim Phillips wrote:
> > > ---
> > moved to recommended section (from required), removed sgmii, added  
> > rgmii-id.
> 
> any reason to remove sgmii?  What is rgmii-id?
> 
UCC doesn't support sgmii.

rgmii-id == RGMII with Internal Delay, see RGMII spec, or http://www.spinics.net/lists/netdev/msg28876.html

Kim
