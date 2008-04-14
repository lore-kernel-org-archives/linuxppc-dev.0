Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED2B5DDEE2
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:00:02 +1000 (EST)
Message-Id: <45197281-8BDA-4296-9D2C-4663841BD74E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080411160654.GA25506@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
Date: Mon, 14 Apr 2008 09:59:56 -0500
References: <20080311171045.GB4684@localhost.localdomain>
	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> From: Anton Vorontsov <avorontsov@ru.mvista.com>
> Subject: [POWERPC] UCC nodes cleanup
>
> - get rid of `model = "UCC"' in the ucc nodes
>  It isn't used anywhere, so remove it. If we'll ever need something
>  like this, we'll use compatible property instead.
> - replace last occurrences of device-id with cell-index.
>  Drivers are modified for backward compatibility's sake.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> Documentation/powerpc/booting-without-of.txt |    6 ++----
> arch/powerpc/boot/dts/mpc832x_mds.dts        |    7 +------
> arch/powerpc/boot/dts/mpc832x_rdb.dts        |    4 ----
> arch/powerpc/boot/dts/mpc836x_mds.dts        |    4 ----
> arch/powerpc/boot/dts/mpc8568mds.dts         |    4 ----
> drivers/net/ucc_geth.c                       |    8 +++++++-
> drivers/net/ucc_geth_mii.c                   |   11 ++++++++---
> drivers/serial/ucc_uart.c                    |   16 ++++++++++++----
> 8 files changed, 30 insertions(+), 30 deletions(-)

applied.

- k
