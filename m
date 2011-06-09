Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE006.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0DA0CB6FEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 04:55:26 +1000 (EST)
Message-ID: <4DF11715.5030001@freescale.com>
Date: Thu, 9 Jun 2011 13:55:17 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<201106090929.23671.arnd@arndb.de>
In-Reply-To: <201106090929.23671.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: konrad.wilk@oracle.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org,
	linux-console@vger.kernel.org, greg@kroah.com,
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
> Then get rid of all the code that takes apart the ioctl command numbers
> again and just do a switch/case based on the command.

I still need to keep that code to maintain binary compatibility with existing
applications that pass the union as a parameter.

I'll fix that after we've updated the applications.  But we have a
chicken-or-the-egg problem where we need the same application to work with the
new and old ioctl interface for a period of time.

-- 
Timur Tabi
Linux kernel developer at Freescale
