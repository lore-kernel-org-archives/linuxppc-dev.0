Return-Path: <ukl@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[92.198.50.35]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B92EB6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 13 Jul 2010 17:31:50 +1000 (EST)
Date: Tue, 13 Jul 2010 09:31:37 +0200
From: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: reduce the size of the defconfigs
Message-ID: <20100713073137.GC26442@pengutronix.de>
References: <20100713170945.26d95641.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20100713170945.26d95641.sfr@canb.auug.org.au>
Cc: Olof Johansson <olof@lixom.net>, ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Linus <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 13, 2010 at 05:09:45PM +1000, Stephen Rothwell wrote:
> This uses Uwe's script (modified by Olof Johansson to speed it up
> somewhat) to reduce the size of all the powerpc defconfigs.  The resulting
IMHO we should add the script to the source, too.  And if it's only for
me to see Olof's optimisation. :-)

> files have been verified to produce the same .config files by generating
> them before and after this patch and comparing the results.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  100 files changed, 51 insertions(+), 133815 deletions(-)
Nice.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-König            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
