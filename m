Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 88FE4DDDA0
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 00:07:15 +1000 (EST)
Message-ID: <49FB020B.8000505@garzik.org>
Date: Fri, 01 May 2009 10:07:07 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
References: <1241042419-19774-1-git-send-email-fkan@amcc.com>	
	<49FAA434.9040106@garzik.org> <1241167748.1781.3.camel@pasglop>
In-Reply-To: <1241167748.1781.3.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Feng Kan <fkan@amcc.com>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Patch 2/2 is just adding the device-tree bits to the platform for
> this driver to match against, so it's no big deal. However, Feng,
> we already mentioned that you do a lot of unrelated changes to the
> Kconfig file that shouldn't be part of this patch, just add the
> entry for this chip, don't move stuff around in Kconfig, unless I
> missed a good reason why this is done that way.


Quite correct -- those drivers/ata/Kconfig changes are bogus.

	Jeff
