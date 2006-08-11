Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id AE2CB67B70
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 04:04:14 +1000 (EST)
Date: Fri, 11 Aug 2006 13:00:13 -0500
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 4/4]: powerpc/cell spidernet ethtool -i version number
	info.
Message-ID: <20060811180013.GB6550@pb15.lixom.net>
References: <20060811170337.GH10638@austin.ibm.com>
	<20060811171117.GL10638@austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060811171117.GL10638@austin.ibm.com>
From: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
	James K Lewis <jklewis@us.ibm.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 11, 2006 at 12:11:17PM -0500, Linas Vepstas wrote:

> This patch adds version information as reported by 
> ethtool -i to the Spidernet driver.

Why does a driver that's in the mainline kernel need to have a version
number besides the kernel version?

I can understand it for drivers like e1000 that Intel maintain outside
of the kernel as well. But spidernet is a fully mainline maintained
driver, right?


-Olof
