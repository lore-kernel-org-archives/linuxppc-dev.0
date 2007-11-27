Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C928CDDE29
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Nov 2007 08:19:22 +1100 (EST)
Date: Tue, 27 Nov 2007 15:22:22 -0600
From: Olof Johansson <olof@lixom.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 2/3] [libata] pata_of_platform: OF-Platform PATA device
	driver
Message-ID: <20071127212222.GB10829@lixom.net>
References: <20071127153708.GA12490@localhost.localdomain>
	<20071127153908.GB14183@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071127153908.GB14183@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Nov 27, 2007 at 06:39:08PM +0300, Anton Vorontsov wrote:
> This driver nicely wraps around pata_platform library functions,
> and provides OF platform bus bindings to the PATA devices.

> +static struct of_device_id pata_of_platform_match[] = {
> +	{ .compatible = "pata-platform", },
> +};

"pata-platform" really means nothing outside of linux. A more
generic label would be useful.


-Olof
