Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4456CDDE07
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 02:42:50 +1000 (EST)
Date: Tue, 8 Apr 2008 11:43:04 -0500
From: Scott Wood <scottwood@freescale.com>
To: Andre Schwarz <andre.schwarz@matrix-vision.de>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
Message-ID: <20080408164304.GG2552@loki.buserror.net>
References: <47F73625.9040903@matrix-vision.de>
	<20080407161036.GA2688@loki.buserror.net>
	<47FB3206.7080406@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47FB3206.7080406@matrix-vision.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 08, 2008 at 10:51:18AM +0200, Andre Schwarz wrote:
> Call Trace:
> [c01f9ef0] [c001c190]  (unreliable)
> [c01f9f10] [c0140c84]
> [c01f9f20] [c0140ccc]
> [c01f9f40] [c014145c]
> [c01f9f60] [c0014014]
> [c01f9fa0] [c01d1a40]
> [c01f9fb0] [c01ce64c]
> [c01f9fc0] [c01c55ac]
> [c01f9ff0] [00003438]

Please turn kallsyms on, which will produce an annotated call trace.  Not
all these addresses were in the System.map fragment.

-Scott
