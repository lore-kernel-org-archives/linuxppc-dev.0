Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75CA9DDF9B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 May 2007 00:00:21 +1000 (EST)
Date: Tue, 1 May 2007 09:00:06 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: Anyone using mpc832x_mds & freescale's GIT repo?
Message-Id: <20070501090006.4c9f5723.kim.phillips@freescale.com>
In-Reply-To: <46370991.3010802@cambridgebroadband.com>
References: <4636081D.2000507@cambridgebroadband.com>
	<20070430135200.23bb6bbf.kim.phillips@freescale.com>
	<46370991.3010802@cambridgebroadband.com>
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

On Tue, 01 May 2007 10:34:09 +0100
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> 
> mention above.  Do you know which *linux* repository is the most
> current for the MPC8323E-MDS-PB board?

yes, linux..normally I'd say paulus' powerpc.git tree on kernel.org, but
today, 832x-MDS is broken there.  You might want to checkout the v2.6.21
tag until the pending patches (to support the ucc phylib) are applied and
merged.

Kim
