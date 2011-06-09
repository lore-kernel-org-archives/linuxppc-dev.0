Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id D9C9DB7021
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 06:25:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 7/7] [v5] drivers/virt: introduce Freescale hypervisor
	management driver
Date: Thu, 9 Jun 2011 22:25:07 +0200
References: <1307646794-26374-1-git-send-email-timur@freescale.com>
	<4DF12345.1040409@freescale.com> <4DF123AA.6070402@oracle.com>
In-Reply-To: <4DF123AA.6070402@oracle.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201106092225.08090.arnd@arndb.de>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, konrad.wilk@oracle.com,
	greg@kroah.com, kumar.gala@freescale.com,
	linux-kernel@vger.kernel.org, cmetcalf@tilera.com,
	akpm@kernel.org, dsaxena@linaro.org, linux-console@vger.kernel.org,
	virtualization@lists.linux-foundation.org,
	Timur Tabi <timur@freescale.com>, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 09 June 2011 21:48:58 Randy Dunlap wrote:
> > So is it okay to stick with 0, or do I need to pick a new number?
> 
> I wasn't suggesting that you change the 0, just note that it has conflicts,
> like other ioctls do.

We normally don't try to maintain binary compatibility with out of tree
kernel patches. That only leads to inferior interfaces finding their way
into the kernel.

	Arnd
