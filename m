Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6F0D9DDF71
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 17:53:54 +1100 (EST)
Date: Fri, 18 Jan 2008 00:51:29 -0600 (CST)
From: Kumar Gala <galak@kernel.crashing.org>
To: Liu Yu <Yu.Liu@freescale.com>
Subject: Re: [PATCH] Fix carry bug in 128-bit unsigned integer adding
In-Reply-To: <12006264992105-git-send-email-Yu.Liu@freescale.com>
Message-ID: <Pine.LNX.4.64.0801180051130.16433@blarg.am.freescale.net>
References: <12006264992105-git-send-email-Yu.Liu@freescale.com>
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

On Fri, 18 Jan 2008, Liu Yu wrote:

> Synchronize it to the definition in include/math-emu/op-4.h for short term.
>
> Signed-off-by: Liu Yu <Yu.Liu@freescale.com>
> ---
>  arch/powerpc/math-emu/op-4.h |   40 ++++++++++++++++++++++++++++++----------
>  1 files changed, 30 insertions(+), 10 deletions(-)

applied.

- k
