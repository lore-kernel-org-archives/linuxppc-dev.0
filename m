Return-Path: <jk@ozlabs.org>
From: Jeremy Kerr <jk@ozlabs.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] spufs: add .gitignore for spu_save_dump.h &
	spu_restore_dump.h
Date: Fri, 25 Apr 2008 08:26:11 +1000
References: <Pine.LNX.4.64.0804241136310.22265@blarg.am.freescale.net>
In-Reply-To: <Pine.LNX.4.64.0804241136310.22265@blarg.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804250826.12128.jk@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar,

> --- /dev/null
> +++ b/arch/powerpc/platforms/cell/spufs/.gitignore
> @@ -0,0 +1,2 @@
> +spu_save_dump.h
> +spu_restore_dump.h

nak - these still need to be tracked (and distributed with the tree), as 
we want to be able to build the kernel without spu-gcc.


Jeremy
