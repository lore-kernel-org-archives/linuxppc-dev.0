Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E640DDDF98
	for <linuxppc-dev@ozlabs.org>; Wed, 16 May 2007 04:25:30 +1000 (EST)
Date: Tue, 15 May 2007 13:21:00 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: fix alignment problem in rh_alloc_align() with
	exact-sized blocks
In-Reply-To: <1179160286213-git-send-email-timur@freescale.com>
Message-ID: <Pine.LNX.4.64.0705151320440.14194@localhost.localdomain>
References: <1179160286213-git-send-email-timur@freescale.com>
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

On Mon, 14 May 2007, Timur Tabi wrote:

> When an rheap is created, the caller can specify the alignment to use.  In
> rh_alloc_align(), if a free block is found that is the exact size needed
> (including extra space for alignment), that configured alignment value is not
> used to align the pointer.  Instead, the default alignment is used.  If the
> default alignment is smaller than the configured alignment, then the returned
> value will not be aligned correctly.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>  arch/powerpc/lib/rheap.c |   22 ++++++++--------------
>  1 files changed, 8 insertions(+), 14 deletions(-)
>

applied.

- k
