Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9AF85B6EE9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 02:36:50 +1000 (EST)
Message-ID: <4DF0F672.8040206@freescale.com>
Date: Thu, 9 Jun 2011 11:36:02 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Randy Dunlap <randy.dunlap@oracle.com>
Subject: Re: [PATCH 7/7] [v4] drivers/virt: introduce Freescale hypervisor
	management driver
References: <1307573154-15838-1-git-send-email-timur@freescale.com>
	<20110608161009.7b05d305.randy.dunlap@oracle.com>
	<201106090938.23027.arnd@arndb.de> <4DF0F5A1.5080008@oracle.com>
In-Reply-To: <4DF0F5A1.5080008@oracle.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Arnd Bergmann <arnd@arndb.de>, konrad.wilk@oracle.com, greg@kroah.com,
	kumar.gala@freescale.com, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com,
	Linux Virtualization <virtualization@lists.linux-foundation.org>,
	dsaxena@linaro.org, linux-console@vger.kernel.org,
	akpm@kernel.org, linuxppc-dev@lists.ozlabs.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Randy Dunlap wrote:
> But it sounds like virt/ needs virt/host/ and virt/guest/ to me.

I'm okay with that idea, except there's a consensus that drivers should be in
drivers/.

-- 
Timur Tabi
Linux kernel developer at Freescale
