Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: libfdt: Trivial cleanup for CHECK_HEADER) 
In-Reply-To: Your message of "Mon, 18 Feb 2008 18:06:31 +1100."
	<20080218070631.GI29975@localhost.localdomain>
References: <20080218070631.GI29975@localhost.localdomain> 
Date: Mon, 18 Feb 2008 08:28:02 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JR6yQ-00016y-LC@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> Currently the CHECK_HEADER() macro is defined local to fdt_ro.c.
> However, there are a handful of functions (fdt_move, rw_check_header,
> fdt_open_into) from other files which could also use it (currently
> they open-code something more-or-less identical).  Therefore, this
> patch moves CHECK_HEADER() to libfdt_internal.h and uses it in those
> places.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

jdl
