Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 76DCCDDF0A
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Aug 2008 18:28:47 +1000 (EST)
Message-ID: <48A3ECB6.8000601@pobox.com>
Date: Thu, 14 Aug 2008 04:28:38 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] gianfar: Call gfar_halt_nodisable() from gfar_halt().
References: <20080812201046.GC27956@loki.buserror.net>
In-Reply-To: <20080812201046.GC27956@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> gfar_halt() was factored out into halting and disabling by commit
> d87eb12785c14de1586e3bad86ca2c0991300339, as the suspend() method
> only wants to do the former.  However, the call to gfar_halt_nodisable()
> from gfar_halt() apparently got lost during the patch respin process.
> 
> This adds it back.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  drivers/net/gianfar.c |    6 ++----
>  1 files changed, 2 insertions(+), 4 deletions(-)

applied
