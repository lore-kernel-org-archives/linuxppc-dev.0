Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7F210DE3A9
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 15:16:25 +1000 (EST)
Message-Id: <5593DB06-B93B-42AC-8D7D-CA00B04AB833@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080814171342.GA20693@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] powerpc/83xx: mpc836x_mds: add support for the nor flash
Date: Thu, 21 Aug 2008 00:16:20 -0500
References: <20080814171342.GA20693@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 14, 2008, at 12:13 PM, Anton Vorontsov wrote:

> This patch adds the localbus node, moves the bcsr node into the
> localbus node, and adds the flash node.
>
> Also enable MTD support in the defconfig.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/boot/dts/mpc836x_mds.dts           |   23 ++++++-
> arch/powerpc/configs/83xx/mpc836x_mds_defconfig |   79 ++++++++++++++ 
> ++++++++-
> 2 files changed, 98 insertions(+), 4 deletions(-)

applied to powerpc-next.

- k
