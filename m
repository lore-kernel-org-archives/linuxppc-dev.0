Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id EB0B4DDF1A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:21:47 +1100 (EST)
Date: Tue, 13 Mar 2007 15:03:07 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 11/19] bootwrapper: Refactor ft_get_prop() into internal
	and external functions.
Message-ID: <20070313220307.GD8072@mag.az.mvista.com>
References: <20070312204154.GK28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204154.GK28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:54PM -0600, Scott Wood wrote:
> The property searching part of ft_get_prop is factored out into an
> internal __ft_get_prop() which does not deal with phandles and does not
> copy the property data.  ft_get_prop() is then a wrapper that does the
> phandle translation and copying.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Mark A. Greer <mgreer@mvista.com>
