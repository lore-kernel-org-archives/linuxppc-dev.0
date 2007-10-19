Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 238E4DDED0
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Oct 2007 00:35:45 +1000 (EST)
Message-ID: <4718C0BA.5060800@freescale.com>
Date: Fri, 19 Oct 2007 09:35:38 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Emil Medve <Emilian.Medve@freescale.com>
Subject: Re: [PATCH] [POWERPC] ucc_geth: Eliminate compile warnings
References: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com>
In-Reply-To: <1192745713-20829-1-git-send-email-Emilian.Medve@Freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, leoli@freescale.com, jgarzik@pobox.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Emil Medve wrote:
> drivers/net/ucc_geth.c: In function 'ucc_geth_startup':
> drivers/net/ucc_geth.c:2614: warning: assignment makes integer from pointer without a cast
> drivers/net/ucc_geth.c:2651: warning: assignment makes integer from pointer without a cast
> 
> Signed-off-by: Emil Medve <Emilian.Medve@Freescale.com>

Acked-by: Timur Tabi <timur@freescale.com>
