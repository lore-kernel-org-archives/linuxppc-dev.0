Return-Path: <olaf@aepfle.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E70C1DDF0D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 02:21:52 +1000 (EST)
Date: Tue, 10 Apr 2007 18:22:29 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: adding Pegasus IDE quirk for pata_via
Message-ID: <20070410162229.GA508@aepfle.de>
References: <20070404111635.GA1855@aepfle.de> <461A3C10.3050104@genesi-usa.com>
	<20070409154026.4d8a0774@the-village.bc.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20070409154026.4d8a0774@the-village.bc.nu>
Cc: linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 09, Alan Cox wrote:

> > Again some comments would be appreciated from anyone who has a better idea on how this controller
> > works. This simple code addition came out of 2 or 3 days of discussion with the Pegasos designer
> > based on his experiences with the chip and is so simple there cannot be much wrong with it
> > apart from coding style and a distinct lack of testing.
> 
> Seems sane to me - as you said the x86 world relies on the BIOS for this
> and in fact pretty much never uses native mode anyway.

The snipped is appearently for drivers/ide.
Where is the correct place for drivers/ata?
