Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1D1EADDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 08:32:07 +1000 (EST)
Message-ID: <46E8689F.3010702@freescale.com>
Date: Wed, 12 Sep 2007 17:30:55 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Esben Haabendal <eha@doredevelopment.dk>
Subject: Re: Problems with mii-bitbang.c on MPC8270
References: <fa1a16f246925e0db38eb3a52e51934e@127.0.0.1>
In-Reply-To: <fa1a16f246925e0db38eb3a52e51934e@127.0.0.1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Esben Haabendal wrote:
> Also, fs_enet_mdio_bb_exit does not work, as shown in the log below.
> Not that I need it, but I guess it should be working when it is there.

I think this is a generic PHY issue, addressed by this patch:

http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042342.html

-Scott
