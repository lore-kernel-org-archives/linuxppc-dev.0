Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E04E7DDDA0
	for <linuxppc-dev@ozlabs.org>; Fri,  1 May 2009 17:26:50 +1000 (EST)
Message-ID: <49FAA434.9040106@garzik.org>
Date: Fri, 01 May 2009 03:26:44 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Feng Kan <fkan@amcc.com>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>
In-Reply-To: <1241042419-19774-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Feng Kan wrote:
> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
>  drivers/ata/Kconfig    |   76 +-
>  drivers/ata/Makefile   |    1 +
>  drivers/ata/sata_dwc.c | 2047 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 2091 insertions(+), 33 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc.c

I don't see a patch 2/2 ?
