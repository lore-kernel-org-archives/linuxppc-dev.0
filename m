Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 1DE85DDDF3
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:32:14 +1100 (EST)
Date: Mon, 12 Mar 2007 15:32:41 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 04/19] bootwrapper: Rename ft_node_add() to
	ft_get_phandle().
Message-ID: <20070312223241.GC31268@mag.az.mvista.com>
References: <20070312204144.GD28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204144.GD28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:44PM -0600, Scott Wood wrote:
> This name better reflects what the function does, which is to
> look up the phandle for an internal node pointer, and add it to the
> internal pointer to phandle table if not found.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Mark A. Greer <mgreer@mvista.com>
