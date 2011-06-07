Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de [212.227.17.8])
	by ozlabs.org (Postfix) with ESMTP id A8F4BB6FE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jun 2011 05:34:38 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
Date: Tue, 7 Jun 2011 21:34:24 +0200
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106072116.21469.arnd@arndb.de> <4DEE7A12.80302@freescale.com>
In-Reply-To: <4DEE7A12.80302@freescale.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106072134.24721.arnd@arndb.de>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, greg@kroah.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, akpm@kernel.org,
	Deepak Saxena <dsaxena@linaro.org>,
	linux-console@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 07 June 2011 21:20:50 Timur Tabi wrote:
> Arnd Bergmann wrote:
> > For the spi flash driver that goes through the hypervisor abstraction,
> > I think drivers/virt/tile would be better than driver/platform/tile,
> > but we should really have a new "abstract flash character driver" subsystem
> > for that.
> 
> Why should it matter that the SPI flash driver goes through the hypervisor
> abstration?  One of the patches in this patchset is a TTY driver that goes
> through the Freescale hypervisor.  I put the drivers in drivers/tty.

The driver in question is for a hypervisor that abstracts the flash memory
using a read/write interface. There is no way you can represent that as
a SPI host driver.

	Arnd
