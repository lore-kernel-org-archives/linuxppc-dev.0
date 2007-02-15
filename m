Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 193E2DDE32
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Feb 2007 10:09:37 +1100 (EST)
Message-ID: <45D4E82B.7020403@garzik.org>
Date: Thu, 15 Feb 2007 18:09:31 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] add delay around sl82c105_reset_engine calls
References: <20070210203512.GA25586@aepfle.de>
	<20070210203614.GA25602@aepfle.de>
In-Reply-To: <20070210203614.GA25602@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> The hald media changed polling does really confuse things.
> Noone knows why the delays are needed, but they give us access to the CD.
> 
> An udelay(50) will give reliable access to the drive, but there is still
> one (or more) EH reset. The drive works without EH resets with udelay(100).
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  drivers/ata/pata_sl82c105.c |    3 +++
>  1 file changed, 3 insertions(+)

applied
