Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 401chj52gPzF1GF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Mar 2018 03:32:53 +1100 (AEDT)
Date: Wed, 14 Mar 2018 17:32:50 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, Jiri Slaby <jslaby@suse.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 44/47] tty: remove bfin_jtag_comm and hvc_bfin_jtag drivers
Message-ID: <20180314163250.GD4279@kroah.com>
References: <20180314153603.3127932-1-arnd@arndb.de>
 <20180314153603.3127932-45-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180314153603.3127932-45-arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 14, 2018 at 04:35:57PM +0100, Arnd Bergmann wrote:
> The blackfin architecture is getting removed, so these drivers
> are not needed any more.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/tty/Kconfig             |  13 --
>  drivers/tty/Makefile            |   1 -
>  drivers/tty/bfin_jtag_comm.c    | 353 ----------------------------------------
>  drivers/tty/hvc/Kconfig         |   9 -
>  drivers/tty/hvc/Makefile        |   1 -
>  drivers/tty/hvc/hvc_bfin_jtag.c | 104 ------------
>  6 files changed, 481 deletions(-)
>  delete mode 100644 drivers/tty/bfin_jtag_comm.c
>  delete mode 100644 drivers/tty/hvc/hvc_bfin_jtag.c

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
