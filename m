Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE013.bigfish.com (ch1ehsobe003.messaging.microsoft.com
	[216.32.181.183]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2B0D0B6FFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 06:24:46 +1000 (EST)
Message-ID: <4DF12BFB.5030102@freescale.com>
Date: Thu, 9 Jun 2011 15:24:27 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<201106090929.23671.arnd@arndb.de> <4DF11715.5030001@freescale.com>
	<201106092220.22246.arnd@arndb.de>
In-Reply-To: <201106092220.22246.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, linux-console@vger.kernel.org, greg@kroah.com,
	linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> The lesson to learn here is obviously not to ship binaries of applications
> to customers before the driver has been merged in a mainline kernel.

Believe me, I know this, but unfortunately I have no control over every aspect
of our development cycle.

> The best way out that I can see is to make the driver carry the proper
> interface in the upstream version, but to have a private patch to support
> both interface versions in the kernel you ship on machines that require
> backwards compatibility. Once you have phased out the user application,
> you can then drop that patch and use the upstream version of the
> interfaces.

I think I can make that work.

-- 
Timur Tabi
Linux kernel developer at Freescale
