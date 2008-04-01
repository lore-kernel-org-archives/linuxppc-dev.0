Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 53303DDF4A
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Apr 2008 08:37:23 +1100 (EST)
Message-ID: <47F2AADF.1070705@freescale.com>
Date: Tue, 01 Apr 2008 16:36:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 2/2 v5] Add DIU platform code for MPC8610HPCD
References: <12069806051060-git-send-email-yorksun@freescale.com>	<1206980605689-git-send-email-yorksun@freescale.com>	<12069806051291-git-send-email-yorksun@freescale.com>
	<20080401140029.be918d87.akpm@linux-foundation.org>
In-Reply-To: <20080401140029.be918d87.akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	scottwood@freescale.com, York Sun <yorksun@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andrew Morton wrote:

> The defconfig change gets almost 100% rejects and probably isn't
> appropriate here and isn't very important.

It's weird that you get rejects, but otherwise you're correct.  defconfigs are
just a convenience, anyway.

-- 
Timur Tabi
Linux kernel developer at Freescale
