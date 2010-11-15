Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Nov 2010 09:30:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Mitch Bradley <wmb@firmworks.com>
Subject: Re: [PATCH 2/2] powerpc: pcm030/032: add pagesize to dts
Message-ID: <20101115223009.GA4895@yookeroo>
References: <1289841916-3825-1-git-send-email-w.sang@pengutronix.de>
	<1289841916-3825-2-git-send-email-w.sang@pengutronix.de>
	<20101115173250.GA22104@oksana.dev.rtsoft.ru>
	<4CE1A0E4.5030505@firmworks.com>
	<20101115212432.GA17754@oksana.dev.rtsoft.ru>
	<AANLkTi=H_zONah7YuKSffkGrSiGa+7-LSbXE+qO=86Zj@mail.gmail.com>
	<4CE1B18F.2030906@firmworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CE1B18F.2030906@firmworks.com>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 15, 2010 at 12:17:51PM -1000, Mitch Bradley wrote:
> In general I think it's better to report parameter values directly,
> instead of inferring them from manufacturer and part numbers.  That
> way you at least have a fighting chance of avoiding a kernel upgrade
> when a part changes.

I tend to agree.  Although a fallback to deducing from the
manufacturer / part id if the pagesize property is missing would be
sensible.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
