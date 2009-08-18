Return-Path: <shemminger@vyatta.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id A096EB7067
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 19 Aug 2009 07:14:31 +1000 (EST)
Received: from mail.vyatta.com (mail.vyatta.com [76.74.103.46])
	by ozlabs.org (Postfix) with ESMTP id 66E2FDDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Aug 2009 07:14:31 +1000 (EST)
Date: Tue, 18 Aug 2009 14:04:18 -0700
From: Stephen Hemminger <shemminger@vyatta.com>
To: John Linn <john.linn@xilinx.com>
Subject: Re: [PATCH] net: add Xilinx emac lite device driver
Message-ID: <20090818140418.347cb8ac@nehalam>
In-Reply-To: <20090818153047.48E42ED8051@mail66-dub.bigfish.com>
References: <20090818153047.48E42ED8051@mail66-dub.bigfish.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Michal Simek <michal.simek@petalogix.com>, netdev@vger.kernel.org,
	Sadanand M <sadanan@xilinx.com>, davem@davemloft.net,
	linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	John Linn <john.linn@xilinx.com>,
	John Williams <john.williams@petalogix.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 18 Aug 2009 09:30:41 -0600
John Linn <john.linn@xilinx.com> wrote:

> +/**
> + * xemaclite_enable_interrupts - Enable the interrupts for the EmacLite device
> + * @drvdata:	Pointer to the Emaclite device private data
> + *
> + * This function enables the Tx and Rx interrupts for the Emaclite device along
> + * with the Global Interrupt Enable.
> + */
> +static void xemaclite_enable_interrupts(struct net_local *drvdata)

Docbook format is really a not necessary on local functions that
are only used in the driver.  It is fine if you want to use it, as
long as the file isn't processed by kernel make docs but
the docbook is intended for automatic generation of kernel API manuals.

-- 
