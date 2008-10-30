Return-Path: <jason.m.hanna.at.coincident@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.159])
	by ozlabs.org (Postfix) with ESMTP id 97C76DDE01
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2008 10:24:45 +1100 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so719259fga.39
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Oct 2008 16:24:43 -0700 (PDT)
Message-ID: <8f9e78f00810301624k5925a52ah924960f869388233@mail.gmail.com>
Date: Thu, 30 Oct 2008 19:24:43 -0400
From: "Jason Hanna" <jason.m.hanna.at.coincident@gmail.com>
To: "Josh Boyer" <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH v3] spi: Add PPC4xx SPI driver
In-Reply-To: <20081029145305.GA3676@yoda.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1225000124-29366-1-git-send-email-sr@denx.de>
	<20081029145305.GA3676@yoda.jdub.homelinux.org>
Cc: spi-devel-general@lists.sourceforge.net, Stefan Roese <sr@denx.de>,
	weo@reccoware.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 29, 2008 at 10:53 AM, Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> Also, do you have a patch for a DTS file that gives an example of how to
> instantiate the SPI stuff in the device tree?

I'll second that request. I've updated the device tree for my Kilauea
(405EX) board but am not sure I have everything correct.

Also, any pointers to sample/test code incorporating a spi protocol
driver would be incredibly helpful. I'm very new to device driver
programming and don't really know what I'm doing yet. I seem to be
getting the spi_ppc4xx and spi_bitbang modules loaded, but am unsure
how to verify proper initialization and what next steps I need to
follow in order to develop and associate a protocol driver.

I'd like to start quite simply - some test routines that would drive
data over the SPI connector on my Kilauea, using a spare GPIO pin as a
chip select. I've got a logic analyzer from which to verify the
results.

I've been reading through all the documentation I can find but am a
little stuck. A concrete example with a SPI protocol driver would be
quite useful.

Thanks,
-jmh
