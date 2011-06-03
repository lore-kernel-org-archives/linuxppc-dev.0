Return-Path: <B04825@freescale.com>
Received: from CH1EHSOBE003.bigfish.com (ch1ehsobe002.messaging.microsoft.com
	[216.32.181.182]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2F04B6FAC
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat,  4 Jun 2011 00:44:34 +1000 (EST)
Message-ID: <4DE8F347.9060104@freescale.com>
Date: Fri, 3 Jun 2011 09:44:23 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/7] [v2] drivers/misc: introduce Freescale hypervisor
	management driver
References: <1306953337-15698-1-git-send-email-timur@freescale.com>
	<201106012340.14237.arnd@arndb.de>
In-Reply-To: <201106012340.14237.arnd@arndb.de>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: kumar.gala@freescale.com, linux-kernel@vger.kernel.org, akpm@kernel.org,
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
> For an ioctl, please follow the normal pattern of defining a separate
> structure for each case, no union.
> 
> You can use a void __user * in the common ioctl function, and pass that
> to the typed argument list in the specific functions.

I have a GPL question.  This header file is currently licensed under the  GPL v2
only.  Does that mean that any application that includes this header file so
that it can talk to the driver/hypervisor also needs to be licensed under the GPL?

-- 
Timur Tabi
Linux kernel developer at Freescale
