Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 97605DE180
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Dec 2007 07:24:38 +1100 (EST)
Message-ID: <4762E67D.30600@pobox.com>
Date: Fri, 14 Dec 2007 15:24:29 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 8/8] gianfar: Magic Packet and suspend/resume support.
References: <20071212173607.GG5596@loki.buserror.net>
In-Reply-To: <20071212173607.GG5596@loki.buserror.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> Jeff, can you ack this to go through Paul's tree
> (assuming nothing wrong with it)?
> 
>  drivers/net/gianfar.c         |  137 ++++++++++++++++++++++++++++++++++++++++-
>  drivers/net/gianfar.h         |   13 +++-
>  drivers/net/gianfar_ethtool.c |   41 ++++++++++++-
>  3 files changed, 185 insertions(+), 6 deletions(-)

ACK
