Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 26CD6DDF49
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Aug 2007 23:47:22 +1000 (EST)
Message-ID: <46D81BE5.4080707@garzik.org>
Date: Fri, 31 Aug 2007 09:47:17 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] bmac: add simple ethtool support for network manager
References: <20070825183259.GA14478@aepfle.de>
In-Reply-To: <20070825183259.GA14478@aepfle.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olaf Hering wrote:
> NetworkManager will not start dhcpd on an interface unless it reports
> link-up state via ethtool.
> 
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> 
> ---
>  drivers/net/bmac.c |   13 +++++++++++++
>  1 file changed, 13 insertions(+)

applied
