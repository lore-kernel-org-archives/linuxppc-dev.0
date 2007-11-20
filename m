Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D2F82DDF14
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Nov 2007 16:54:35 +1100 (EST)
Date: Mon, 19 Nov 2007 23:53:02 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH 5/5] powerpc: handle mpc8360 rev. 2.1 RGMII timing erratum
In-Reply-To: <20071105121551.a28b5446.kim.phillips@freescale.com>
Message-ID: <Pine.LNX.4.64.0711192352440.1217@blarg.am.freescale.net>
References: <20071105121551.a28b5446.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: netdev@vger.kernel.org, Li Yang <leoli@freescale.com>, jgarzik@pobox.com,
	paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 5 Nov 2007, Kim Phillips wrote:

> if on a rev. 2.1, adjust UCC clock and data timing characteristics
> as specified in the rev.2.1 erratum #2.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
>  arch/powerpc/platforms/83xx/mpc836x_mds.c |   31 ++++++++++++++++++++++++++--
>  1 files changed, 28 insertions(+), 3 deletions(-)
>

applied.

- k
