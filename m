Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 4487ADDF37
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:21:49 +1100 (EST)
Date: Tue, 13 Mar 2007 15:05:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 12/19] bootwrapper: Make ft_get_parent() return a phandle,
	and NULL if already top-level.
Message-ID: <20070313220542.GE8072@mag.az.mvista.com>
References: <20070312204156.GL28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204156.GL28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:56PM -0600, Scott Wood wrote:
> Most of ft_get_parent() is factored out into __ft_get_parent(), which
> deals only in internal node pointers.  The ft_get_parent() wrapper
> handles phandle conversion in both directions (previously,
> ft_get_parent() did not convert its return value).
> 
> It also now returns NULL as the parent of the toplevel node, rather than
> just returning the toplevel node again (which made it rather useless in
> loops).
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Mark A. Greer <mgreer@mvista.com>
