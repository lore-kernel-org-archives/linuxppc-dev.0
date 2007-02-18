Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound3-dub-R.bigfish.com (mail-dub.bigfish.com
	[213.199.154.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id EE515DDE30
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 12:22:30 +1100 (EST)
Message-ID: <45D7AA4B.2020004@am.sony.com>
Date: Sat, 17 Feb 2007 17:22:19 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 2/3] zImage: Cleanup and improve prep_kernel()
References: <20070216062739.62AE8DDD08@ozlabs.org>
In-Reply-To: <20070216062739.62AE8DDD08@ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> This patch rewrites prep_kernel() in the zImage wrapper code to be
> clearer and more flexible.  Notable changes:

> --- working-2.6.orig/arch/powerpc/boot/main.c

> +struct elf_info {
> +	unsigned long loadsize;
> +	unsigned long memsize;
> +	unsigned long elfoffset;
> +} vmlinux;


This global instance (vmlinux) doesn't seem to be used anywhere, so
it can be removed.

-Geoff
