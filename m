Return-Path: <alan@lxorguk.ukuu.org.uk>
Received: from the-village.bc.nu (unknown [81.2.110.250])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3FA87DDF24
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 00:37:33 +1000 (EST)
Date: Mon, 9 Apr 2007 15:40:26 +0100
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: adding Pegasus IDE quirk for pata_via
Message-ID: <20070409154026.4d8a0774@the-village.bc.nu>
In-Reply-To: <461A3C10.3050104@genesi-usa.com>
References: <20070404111635.GA1855@aepfle.de> <461A3C10.3050104@genesi-usa.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	linux-ide@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Again some comments would be appreciated from anyone who has a better idea on how this controller
> works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
> based on his experiences with the chip and is so simple there cannot be much wrong with it
> apart from coding style and a distinct lack of testing.

Seems sane to me - as you said the x86 world relies on the BIOS for this
and in fact pretty much never uses native mode anyway.

Patch looks fine except pci_find_device is obsolete, please use
pci_get_device and refcount safe APIs.
