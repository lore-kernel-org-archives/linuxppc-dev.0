Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: dtc: Use the same endian-conversion functions as libfdt 
In-reply-to: <20080625042753.GC8284@yookeroo.seuss> 
References: <20080625042753.GC8284@yookeroo.seuss>
Date: Mon, 14 Jul 2008 13:50:06 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1KIT7e-0006qR-PC@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Currently both libfdt and dtc define a set of endian conversion macros
> for accessing the device tree blob which is always big-endian.  libfdt
> uses names like cpu_to_fdt32() and dtc uses names like cpu_to_be32 (as
> the Linux kernel).  This patch switches dtc over to using the libfdt
> macros (including libfdt_env.h to supply them).  This has a couple of
> small advantages:
> 	- Removes some code duplication
> 	- Will make conversion a bit easier if we ever need to produce
>           little-endian device tree blobs.
> 	- dtc no longer needs to pull in netinet/in.h simply for the
>           ntohs() and ntohl() functions
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
