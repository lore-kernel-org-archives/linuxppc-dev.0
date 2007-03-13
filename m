Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id A219EDDEB7
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Mar 2007 10:21:46 +1100 (EST)
Date: Tue, 13 Mar 2007 14:55:20 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 06/19] bootwrapper: Preserve the pp pointer in
	ft_make_space() when calling ft_reorder().
Message-ID: <20070313215520.GA8072@mag.az.mvista.com>
References: <20070312204147.GF28545@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070312204147.GF28545@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 02:41:47PM -0600, Scott Wood wrote:
> The ft_reorder() function may change the start of the region of interest,
> so the pointer provided by the caller into that region must be fixed up
> to still point to the same datum.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Acked-by: Mark A. Greer <mgreer@mvista.com>
