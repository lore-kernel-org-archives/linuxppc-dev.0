Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18178.55231.813138.369480@cargo.ozlabs.ibm.com>
Date: Wed, 3 Oct 2007 09:43:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: Valentine Barshak <vbarshak@ru.mvista.com>
Subject: Re: [PATCH] Remove unnecessary memset from physmap_of driver
In-Reply-To: <20071002155328.GA3574@ru.mvista.com>
References: <20071002155328.GA3574@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Valentine Barshak writes:

> No need for memset to zero memory here, since we use kzalloc.
> 
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>
> ---
>  drivers/mtd/maps/physmap_of.c |    1 -

Please cc the mtd list (linux-mtd@lists.infradead.org) and/or David
Woodhouse on MTD patches.  Posting them to linuxppc-dev isn't going to
get them upstream.

Paul.
