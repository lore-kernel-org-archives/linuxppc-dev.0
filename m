Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 87BCD1A03C8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Mar 2015 23:44:17 +1100 (AEDT)
Date: Sat, 7 Mar 2015 03:32:54 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kevin Hao <haokexin@gmail.com>
Subject: Re: [PATCH v2 10/11] tty: kconfig: remove the superfluous dependency
 on PPC_OF
Message-ID: <20150307023254.GA8944@kroah.com>
References: <1424952503-8247-1-git-send-email-haokexin@gmail.com>
 <1424952503-8247-11-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1424952503-8247-11-git-send-email-haokexin@gmail.com>
Cc: Jiri Slaby <jslaby@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-serial@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 26, 2015 at 08:08:22PM +0800, Kevin Hao wrote:
> In the current kernel, the CONFIG_PPC_OF is always 'y' for the ppc
> arch. So we don't need to check it with other ppc specific options.
> 
> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> v2: No change.
> 
>  drivers/tty/serial/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 

Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
