Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401chb1m2MzF0pX
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:32:46 +1100 (AEDT)
Date: Wed, 14 Mar 2018 17:32:43 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 45/47] tty: hvc: remove tile driver
Message-ID: <20180314163243.GC4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-46-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314153603.3127932-46-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 04:35:58PM +0100, Arnd Bergmann wrote:
> The Tile architecture is obsolete and getting removed from the kernel,
> this removes the corresponding console driver as well.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/hvc/Makefile   |   1 -
>  drivers/tty/hvc/hvc_tile.c | 196 ---------------------------------------------
>  2 files changed, 197 deletions(-)
>  delete mode 100644 drivers/tty/hvc/hvc_tile.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
