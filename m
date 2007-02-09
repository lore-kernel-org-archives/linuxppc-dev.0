Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id EB912DDED4
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:04:42 +1100 (EST)
Date: Fri, 9 Feb 2007 16:05:40 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 17/19] bootwrapper: Add dt_ops methods.
Message-ID: <20070209230540.GB12035@mag.az.mvista.com>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230144.GQ3849@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230144.GQ3849@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 05:01:44PM -0600, Scott Wood wrote:

<snip>

> diff --git a/arch/powerpc/boot/flatdevtree_misc.c b/arch/powerpc/boot/flatdevtree_misc.c
> index 39fa010..10e5f27 100644
> --- a/arch/powerpc/boot/flatdevtree_misc.c
> +++ b/arch/powerpc/boot/flatdevtree_misc.c

> +void *fdtm_get_parent(const void *phandle)
> +void *fdtm_create_node(const void *phandle, const char *name)
> +void *fdtm_find_node_by_prop_value(const void *prev, const char *propname,

Make these static.  Also, we should probably make the naming consistent
so would you mind making them all fdtm_* or whatever?

Mark
