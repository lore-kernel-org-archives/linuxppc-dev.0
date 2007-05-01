Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 564DDDDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 00:26:36 +1000 (EST)
Date: Tue, 1 May 2007 09:26:24 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: Anyone using mpc832x_mds & freescale's GIT repo?
Message-Id: <20070501092624.679c080b.kim.phillips@freescale.com>
In-Reply-To: <46374938.6090707@cambridgebroadband.com>
References: <4636081D.2000507@cambridgebroadband.com>
	<20070430135200.23bb6bbf.kim.phillips@freescale.com>
	<46370991.3010802@cambridgebroadband.com>
	<20070501090006.4c9f5723.kim.phillips@freescale.com>
	<46374938.6090707@cambridgebroadband.com>
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

On Tue, 01 May 2007 15:05:44 +0100
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> 
> Would you recommend using powerpc.git v2.6.21 in preference to the 2.6.11
> kernel that comes with the latest Freescale BSP (MPC832xE_MDS_K26_20070130-LTIB.iso)?

personally, and in general, yes.  But it really depends on your
application, device driver requirements, etc..

Kim
