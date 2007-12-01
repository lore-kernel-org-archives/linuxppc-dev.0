Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B612DDE05
	for <linuxppc-dev@ozlabs.org>; Sun,  2 Dec 2007 08:54:09 +1100 (EST)
Message-ID: <4751D7FD.8010801@pobox.com>
Date: Sat, 01 Dec 2007 16:54:05 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [1/12] pasemi_mac: RX/TX ring management cleanup
References: <20071129025410.GA17215@lixom.net>
	<20071129025428.GB17215@lixom.net>
In-Reply-To: <20071129025428.GB17215@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> pasemi_mac: RX/TX ring management cleanup
> 
> Prepare a bit for supporting multiple TX queues by cleaning up some
> of the ring management and shuffle things around a bit.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>

applied 1-12
