Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id B29AC67BA9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 01:21:41 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/11] qe_lib: Add common files
Date: Thu, 21 Sep 2006 17:21:39 +0200
Message-ID: <F6AD7E21CDF4E145A44F61F43EE6D9399B44FE@tmnt04.transmode.se>
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "Li Yang" <leoli@freescale.com>,
	<linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> diff --git a/include/asm-powerpc/qe.h b/include/asm-powerpc/qe.h
> +#define QE_MURAM_DATAONLY_BASE	((uint)0x0)
> +#define QE_MURAM_NOSPACE		((uint)0x7fffffff)
> +#define QE_MURAM_DATAONLY_SIZE	((uint)(48 * 1024) -=20
> QE_MURAM_DATAONLY_BASE)

QE_MURAM_DATAONLY_SIZE is 16*1024 on 8321

Also, you have line wrapping that has mangled all long lines in all
patches.

 Jocke
