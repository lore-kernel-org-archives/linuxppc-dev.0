Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C141CDDF56
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 02:52:09 +1000 (EST)
Date: Tue, 10 Apr 2007 18:52:46 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [PATCH] autodetect serial console on efika
Message-ID: <20070410165246.GC508@aepfle.de>
References: <20070331150823.GA25421@aepfle.de>
	<461A3817.8080303@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <461A3817.8080303@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 09, Matt Sealey wrote:

> It is entirely possible that a user may redirect the OF console output to
> the PSC6 controller or another internal or external serial device (PCI
> serial controller or so). In this case, the boot console will simply switch
> to the UART on the back, which may be some other custom device and not a
> valid console.

How many serial drivers are enabled in the public Efika firmware?
With my change, both /failsafe and the /builtin/serial work.
Both have device_type == "serial"
