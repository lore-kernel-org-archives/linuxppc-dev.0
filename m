Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 63150DDE09
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Feb 2008 02:32:41 +1100 (EST)
Message-Id: <72B60725-FB4A-42FA-832D-8FD5434B9042@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
In-Reply-To: <20080201150126.GB26545@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] get rid of `model = "UCC"' in the ucc nodes
Date: Fri, 1 Feb 2008 09:32:38 -0600
References: <20080201150126.GB26545@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 1, 2008, at 9:01 AM, Anton Vorontsov wrote:

> It isn't used anywhere, so remove it. If we'll ever need something
> like this, we'll use compatible property instead.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> Rebased on top of recent tree.
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
> index 410c847..dcf9758 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1675,7 +1675,6 @@ platforms are moved over to use the flattened- 
> device-tree model.
> 	ucc@2000 {
> 		device_type = "network";
> 		compatible = "ucc_geth";
> -		model = "UCC";
> 		device-id = <1>;

can we change device-id to cell-index?

>
- k
