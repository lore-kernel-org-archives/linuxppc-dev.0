Return-Path: <drzeus-mmc@drzeus.cx>
Received: from smtp.drzeus.cx (server.drzeus.cx [85.8.24.28])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C14D1DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2008 07:06:56 +1100 (EST)
Date: Sun, 30 Nov 2008 21:06:48 +0100
From: Pierre Ossman <drzeus-mmc@drzeus.cx>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v2] mmc: Add mmc_vddrange_to_ocrmask() helper function
Message-ID: <20081130210648.77b8843a@mjolnir.drzeus.cx>
In-Reply-To: <20081126195417.GA26264@oksana.dev.rtsoft.ru>
References: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
	<20081030195632.GB13640@oksana.dev.rtsoft.ru>
	<20081108215537.12cdf5f6@mjolnir.drzeus.cx>
	<20081126195417.GA26264@oksana.dev.rtsoft.ru>
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

On Wed, 26 Nov 2008 22:54:17 +0300
Anton Vorontsov <avorontsov@ru.mvista.com> wrote:

> This function sets the OCR mask bits according to provided voltage
> ranges. Will be used by the mmc_spi OpenFirmware bindings.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> 
> Hi Pierre,
> 
> Sorry for the delay.
> 

This looks perfect. Just tell me when you want me to queue it up.

Rgds
-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  rdesktop, core developer          http://www.rdesktop.org

  WARNING: This correspondence is being monitored by the
  Swedish government. Make sure your server uses encryption
  for SMTP traffic and consider using PGP for end-to-end
  encryption.
