Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6A180DDF4D
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 07:10:23 +1000 (EST)
Date: Thu, 19 Jul 2007 16:10:13 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 5/5] move 83xx into multiplatform
Message-Id: <20070719161013.9f982d8f.kim.phillips@freescale.com>
In-Reply-To: <20070713184824.312271421@arndb.de>
References: <20070713184452.466490031@arndb.de>
	<20070713184824.312271421@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 13 Jul 2007 20:44:57 +0200
Arnd Bergmann <arnd@arndb.de> wrote:

> MPC83xx based machines don't need their own kernel,
> but can run one that is shared with the other 6xx
> compatible machines, so we should allow that
> in Kconfig.
> 
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

tested, works.  Kumar, can we get this in?

Kim
