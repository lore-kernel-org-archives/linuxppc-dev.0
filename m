Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8E4B3DDF07
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 17:59:05 +1000 (EST)
Message-ID: <489AAB3E.8020507@pobox.com>
Date: Thu, 07 Aug 2008 03:58:54 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 2/3] gianfar: Magic Packet and suspend/resume support.
References: <20080625215119.GB11784@loki.buserror.net>
In-Reply-To: <20080625215119.GB11784@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    5 +-
>  arch/powerpc/sysdev/fsl_soc.c                |    3 +
>  drivers/net/gianfar.c                        |  118 +++++++++++++++++++++++++-
>  drivers/net/gianfar.h                        |   12 ++-
>  drivers/net/gianfar_ethtool.c                |   41 +++++++++-
>  include/linux/fsl_devices.h                  |    1 +
>  6 files changed, 172 insertions(+), 8 deletions(-)

did this ever get ack'd by Kumar?  I don't have a record of it.
