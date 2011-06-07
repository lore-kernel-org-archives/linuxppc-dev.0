Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE005.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 926BFB6FD6
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jun 2011 05:21:01 +1000 (EST)
Message-ID: <4DEE7A12.80302@freescale.com>
Date: Tue, 7 Jun 2011 14:20:50 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106070908.16301.arnd@arndb.de> <4DEE567E.7080102@tilera.com>
	<201106072116.21469.arnd@arndb.de>
In-Reply-To: <201106072116.21469.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
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

Arnd Bergmann wrote:
> For the spi flash driver that goes through the hypervisor abstraction,
> I think drivers/virt/tile would be better than driver/platform/tile,
> but we should really have a new "abstract flash character driver" subsystem
> for that.

Why should it matter that the SPI flash driver goes through the hypervisor
abstration?  One of the patches in this patchset is a TTY driver that goes
through the Freescale hypervisor.  I put the drivers in drivers/tty.

-- 
Timur Tabi
Linux kernel developer at Freescale
