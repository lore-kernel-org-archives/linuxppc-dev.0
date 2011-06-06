Return-Path: <B04825@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
	[65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4125EB6F8F
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  7 Jun 2011 02:09:54 +1000 (EST)
Message-ID: <4DECFBC5.6070205@freescale.com>
Date: Mon, 6 Jun 2011 11:09:41 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106061742.01974.arnd@arndb.de> <4DECF6B3.5020700@freescale.com>
	<201106061803.58531.arnd@arndb.de>
In-Reply-To: <201106061803.58531.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
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
> When we talked about the situation of drivers/misc and drivers/char at
> one of the recent conferences, a broad consensus was that they are in
> need of a maintainer, which I foolishly signed up for. Deepak wanted
> to send an update to the MAINTAINERS file for this (I guess I can do
> that too, since he must have forgotten about it), but the main idea is
> that I'm there to say no to any driver that someone tries to add there,
> unless there are really good reasons why it is actually a good place
> to live for that driver.

Can you give me an example of a driver that *does* belong in drivers/misc?
Frankly, I just don't see what's wrong with a repository of various drivers that
don't really belong anywhere else.

And what about my concern that my driver will be the only one in drivers/virt?

-- 
Timur Tabi
Linux kernel developer at Freescale
