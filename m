Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id CA5BD2C0102
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Aug 2013 04:39:55 +1000 (EST)
Date: Mon, 12 Aug 2013 11:39:54 -0700
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCH] tile: various console improvements
Message-ID: <20130812183954.GA19875@kroah.com>
References: <201308071458.r77EwWuV013082@farm-0012.internal.tilera.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201308071458.r77EwWuV013082@farm-0012.internal.tilera.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 06, 2013 at 02:11:21PM -0400, Chris Metcalf wrote:
> This change improves and cleans up the tile console.
> 
> - We enable HVC_IRQ support on tilegx, with the addition of a new
>   Tilera hypervisor API for tilegx to allow a console IPI.  If IPI
>   support is not available we fall back to the previous polling mode.
> 
> - We simplify the earlyprintk code to use CON_BOOT and eliminate some
>   of the other supporting earlyprintk code.
> 
> - A new tile_console_write() primitive is used to send output to
>   the console and is factored out of the hvc_tile driver.
>   This lets us support a "sim_console" boot argument to allow using
>   simulator hooks to send output to the "console" as a slightly
>   faster alternative to emulating the hardware more directly.
> 
> Signed-off-by: Chris Metcalf <cmetcalf@tilera.com>

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
