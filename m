Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE015.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 386CBB6F18
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 02:27:41 +1000 (EST)
Message-ID: <4DECFFF3.6060601@freescale.com>
Date: Mon, 6 Jun 2011 11:27:31 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106061803.58531.arnd@arndb.de> <4DECFBC5.6070205@freescale.com>
	<201106061824.53844.arnd@arndb.de>
In-Reply-To: <201106061824.53844.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, akpm@kernel.org,
	Deepak Saxena <dsaxena@linaro.org>,
	linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> I have no doubt that more of these will come. Chris Metcalf is currently
> looking for a home for his tilera hypervisor drivers, and we have the
> microsoft hyperv drivers in drivers/staging, so they will hopefully
> move to a proper place later. We also have similar drivers in other
> places, e.g. drivers/ps3/ps3-sys-manager.c, drivers/s390/char/vmcp.c
> or parts of drivers/xen.

Alright, drivers/virt it is.  I'll post a v4 once everyone else has had a chance
to comment on v3.

-- 
Timur Tabi
Linux kernel developer at Freescale
