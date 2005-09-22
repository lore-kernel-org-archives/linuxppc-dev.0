Return-Path: <hch@lst.de>
Date: Thu, 22 Sep 2005 20:31:26 +0200
From: Christoph Hellwig <hch@lst.de>
To: Jon Loeliger <jdl@freescale.com>
Message-ID: <20050922183126.GA18853@lst.de>
References: <E1EIVg5-0001HI-E8@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <E1EIVg5-0001HI-E8@jdl.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc Merge asm-ppc*/seccomp.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> +#include <linux/thread_info.h>
> +
> +#if defined(__powerpc64__) && !defined(TIF_32BIT)
> +#error "unexpected TIF_32BIT on ppc64"
> +#endif

just kill this check, it's rather pointless
