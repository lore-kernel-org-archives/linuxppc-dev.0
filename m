Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE004.bigfish.com (am1ehsobe004.messaging.microsoft.com
	[213.199.154.207])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 01563B6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 20 Jul 2011 03:54:58 +1000 (EST)
Date: Tue, 19 Jul 2011 12:54:47 -0500
From: Scott Wood <scottwood@freescale.com>
To: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Subject: Re: [PATCH 13/14] 85xx: consolidate of_platform_bus_probe calls
Message-ID: <20110719125447.19c964d1@schlenkerla.am.freescale.net>
In-Reply-To: <1311065631-3429-14-git-send-email-dbaryshkov@gmail.com>
References: <1311065631-3429-1-git-send-email-dbaryshkov@gmail.com>
	<1311065631-3429-14-git-send-email-dbaryshkov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: Paul Mackerras <paulus@samba.org>,
	Linux PPC Development <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 19 Jul 2011 12:53:50 +0400
Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:

> +static struct of_device_id __initdata mpc85xx_common_ids[] = {
> +	{ .type = "soc", },
> +	{ .compatible = "soc", },
> +	{ .compatible = "simple-bus", },
> +	{ .compatible = "gianfar", },
> +	{ .compatible = "fsl,qe", },
> +	{ .compatible = "fsl,cpm2", },
> +	{},
> +};

Same comment as for 83xx regarding localbus and compatibility with old
device trees.

-Scott
