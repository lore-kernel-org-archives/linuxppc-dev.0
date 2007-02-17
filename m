Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CDD29DDDFE
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Feb 2007 07:36:19 +1100 (EST)
Message-ID: <45D7673D.3070202@garzik.org>
Date: Sat, 17 Feb 2007 15:36:13 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
	CD drives
References: <20070210203512.GA25586@aepfle.de>
	<20070210203614.GA25602@aepfle.de>
	<45D4E82B.7020403@garzik.org> <20070216092046.GA2572@aepfle.de>
In-Reply-To: <20070216092046.GA2572@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackeras <paulus@samba.org>, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> Change the default for the built-in IDE on p610/p615/p630 from
> ide to libata. libata has better error handling and the drive can
> recover when hald does its CD media polling.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  arch/powerpc/configs/ppc64_defconfig   |    4 ++--
>  arch/powerpc/configs/pseries_defconfig |    4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)

ACK the patch.  I presume Paul will apply it, as its within his file 
hierarchy
