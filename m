Return-Path: <drzeus-mmc@drzeus.cx>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4D6A6DDE00
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 07:56:20 +1100 (EST)
Date: Sat, 8 Nov 2008 21:50:56 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 0/3 RFC] MMC SPI support for OpenFirmware platforms
Message-ID: <20081108215056.5ad2abe7@mjolnir.drzeus.cx>
In-Reply-To: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
References: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 30 Oct 2008 22:55:46 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> 
> Pierre, the approach is somewhat similar to this one:
> http://lkml.org/lkml/2008/5/26/135
> Posted few months ago.
> 
> I know you don't like it, but I ask you to reconsider it. The
> I2C and SPI cases are similar, and recently we tried to write
> bindings for some I2C GPIO controllers.
> 

This new version is a bit better in that you've generalised thing more.
I'd still prefer if we can have an interface where the driver doesn't
have to know that it is on an ACPI/OF/EFI/whatnot host, but I can live
with this model for now.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
