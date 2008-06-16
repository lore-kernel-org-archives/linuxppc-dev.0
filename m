Return-Path: <scottwood@freescale.com>
Date: Mon, 16 Jun 2008 11:49:15 -0500
From: Scott Wood <scottwood@freescale.com>
To: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH] [82xx] powerpc: Add support for mpc8247 based board
	MGCOGE from keymile.
Message-ID: <20080616164915.GA14020@loki.buserror.net>
References: <20080612153215.GB2756@loki.buserror.net>
	<4852A144.6090204@denx.de> <20080616072625.GB28470@yookeroo.seuss>
	<4856350E.4080602@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4856350E.4080602@denx.de>
Cc: linuxppc-dev@ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 16, 2008 at 11:40:30AM +0200, Heiko Schocher wrote:
> The reg entry is wrong, the Flash is on CS5. Here the updated version of
> the patch:

You need to update the ranges property as well.

-Scott
