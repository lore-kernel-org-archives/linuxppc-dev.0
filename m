Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 908A2DE1BC
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Jan 2008 11:46:21 +1100 (EST)
Message-Id: <029506D4-77A3-4F3D-8AEC-42676FBB2634@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080125143700.GA24027@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 6/5] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
Date: Fri, 25 Jan 2008 10:33:51 -0600
References: <20080124151850.GA15190@localhost.localdomain>
	<20080125143700.GA24027@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 25, 2008, at 8:37 AM, Anton Vorontsov wrote:

> It isn't used anywhere, so remove it. If we'll ever need something
> like this, we'll use compatible property instead.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> New cleanup in this series...
>
> Documentation/powerpc/booting-without-of.txt |    1 -
> arch/powerpc/boot/dts/mpc832x_mds.dts        |    3 ---
> arch/powerpc/boot/dts/mpc832x_rdb.dts        |    2 --
> arch/powerpc/boot/dts/mpc836x_mds.dts        |    2 --
> arch/powerpc/boot/dts/mpc8568mds.dts         |    2 --
> 5 files changed, 0 insertions(+), 10 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index a3b6e2a..ab9f0bf 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1675,7 +1675,6 @@ platforms are moved over to use the flattened- 
> device-tree model.
> 	ucc@2000 {
> 		device_type = "network";
> 		compatible = "ucc_geth";
> -		model = "UCC";
> 		device-id = <1>;

can device-id be changed to cell-index?

- k
