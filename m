Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BE51DDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 03:00:25 +1000 (EST)
Date: Thu, 16 Aug 2007 19:00:32 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: adding Pegasus IDE quirk for pata_via
Message-ID: <20070816170032.GA26962@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <461A3C10.3050104@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <461A3C10.3050104@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 09, Matt Sealey wrote:

> +				if (bridge) {
> +					u8 iir, irqlist[4] = { 14, 15, 10, 
> 11 };
> +
> +					pci_read_config_byte(bridge, 
> VIA_IDE_STEERING, &iir);

What value has VIA_IDE_STEERING?
Googles only reference is your own posting.
