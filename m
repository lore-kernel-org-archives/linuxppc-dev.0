Return-Path: <kim.phillips@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 7AA78DDE0E
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 03:45:17 +1100 (EST)
Date: Wed, 14 Mar 2007 11:45:10 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
Message-Id: <20070314114510.3c2db987.kim.phillips@freescale.com>
In-Reply-To: <D951C3CB-F606-455B-B048-6C03D06BDD7D@kernel.crashing.org>
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<17911.31029.598986.827186@cargo.ozlabs.ibm.com>
	<20070314155900.GA10075@ld0162-tx32.am.freescale.net>
	<D951C3CB-F606-455B-B048-6C03D06BDD7D@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 14 Mar 2007 11:08:57 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> 
> For example, the majority of 83xx boards don't need cuImage support  
> (at least I don't think they do) since they only ever existed in arch/ 
> powerpc.

believe it or not, I got an 8323 board last week with u-boot 1.1.3 preinstalled.  83xx need cuimage badly.

Kim
