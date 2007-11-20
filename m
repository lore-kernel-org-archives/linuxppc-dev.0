Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B32CDDE03
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:36:28 +1100 (EST)
Date: Tue, 20 Nov 2007 15:35:06 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] commit e8f605cd71aa09a8f8b73f410a15d2a46022a60e
In-Reply-To: <20071017234100.7729.85901.stgit@trillian.cg.shawcable.net>
Message-ID: <Pine.LNX.4.64.0711201534520.17614@blarg.am.freescale.net>
References: <20071017234100.7729.85901.stgit@trillian.cg.shawcable.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 17 Oct 2007, Grant Likely wrote:

> From: Grant Likely <grant.likely@secretlab.ca>
>
> mpc8349emitx(gp): add UHCI and USB storage support
>
>     USB support for the 8349itx got added a while back; but the defconfig
>     never got updated.  This patch adds the appropriate USB config options
>     to defconfig
>
>     Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
>     CC: Scott Wood <scottwood@freescale.com>
>     CC: Kumar Gala <galak@kernel.crashing.org>
>     CC: Timur Tabi <timur@freescale.com>
> ---
>
>  arch/powerpc/configs/mpc834x_itx_defconfig   |    2 -
>  arch/powerpc/configs/mpc834x_itxgp_defconfig |   88 ++++++++++++++++++++++++++
>  2 files changed, 88 insertions(+), 2 deletions(-)

applied.

- k
