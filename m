Return-Path: <hollis@penguinppc.org>
Subject: Re: common flatdevtree code
From: Hollis Blanchard <hollis@penguinppc.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20060907003625.GA15533@mag.az.mvista.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
	<17662.17895.852128.729679@cargo.ozlabs.ibm.com>
	<20060907003625.GA15533@mag.az.mvista.com>
Content-Type: text/plain
Date: Thu, 07 Sep 2006 02:43:31 -0500
Message-Id: <1157615011.18137.14.camel@diesel>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks Mark!

On Wed, 2006-09-06 at 17:36 -0700, Mark A. Greer wrote:
> void *ft_find_device(const void *bphp, const char *srch_path)

How about "ft_find_node"? I renamed that and made a couple other small
changes. In particular:
- u8->int
- exit and free -> ft_exit and ft_free (so they can be wrapped in
flatdevtree_env.h)
- moved those inlines out of flatdevtree.h, since they don't need to be
exported

I just put up a Mercurial tree. I didn't include your flatdevtree_misc.c
since it's kernel-specific, and I added a userspace flatdevtree_env.h.

To get the source:
hg clone http://unsanctioned.org/flatdevtree/hgweb.py flatdevtree

I'd like to add some unit tests in the near future (e.g. comparing with
dtc output), but I wasted a couple hours screwing with a makefile
instead. :(

By the way, could you send a patch adding your copyright info?

-Hollis
