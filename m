Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7A0CDDDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 10:21:28 +1000 (EST)
Message-ID: <4716A702.7050907@pobox.com>
Date: Wed, 17 Oct 2007 20:21:22 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] fs_enet: Update for API changes
References: <20071017174243.GA4462@loki.buserror.net>
In-Reply-To: <20071017174243.GA4462@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> This driver was recently broken by several changes for which this
> driver was not (or was improperly) updated:
> 
> 1. SET_MODULE_OWNER() was removed.
> 2. netif_napi_add() was only being called when building with
> the old CPM binding.
> 3. The received/budget test was backwards.
> 4. to_net_dev() was wrong -- the device struct embedded in
> the net_device struct is not the same as the of_platform
> device in the private struct.
> 5. napi_disable/napi_enable was being called even when napi
> was not being used.
> 
> These changes have been fixed, and napi is now on by default.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

applied
