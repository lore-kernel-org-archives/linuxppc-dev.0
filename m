Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8F801007D1
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Nov 2009 10:35:10 +1100 (EST)
Message-ID: <4B05D627.1070403@garzik.org>
Date: Thu, 19 Nov 2009 18:35:03 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: ashish kalra <ashish.kalra@freescale.com>
Subject: Re: [PATCH][v3] Add asynchronous notification support
References: <Pine.WNT.4.64.0907012055100.868@B00888-02.fsl.freescale.net>
In-Reply-To: <Pine.WNT.4.64.0907012055100.868@B00888-02.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/01/2009 11:29 AM, ashish kalra wrote:
> Enable device hot-plug support on Port multiplier fan-out ports
> v3 fixes whitespace/identation issues
>
> Signed-off-by: Ashish Kalra <Ashish.Kalra@freescale.com>
> ---
> drivers/ata/sata_fsl.c | 15 ++++++++++-----
> 1 files changed, 10 insertions(+), 5 deletions(-)

applied #upstream
