Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [70.61.120.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 90B81DDE0E
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 09:01:48 +1100 (EST)
Date: Tue, 22 Jan 2008 16:12:39 -0500
From: "John W. Linville" <linville@tuxdriver.com>
To: Masakazu Mokuno <mokuno@sm.sony.co.jp>
Subject: Re: [PATCH 0/6] PS3: gelic: gelic updates for 2.6.25
Message-ID: <20080122211239.GC3206@tuxdriver.com>
References: <20071213181146.BF69.MOKUNO@sm.sony.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213181146.BF69.MOKUNO@sm.sony.co.jp>
Cc: netdev@vger.kernel.org, Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 07:38:28PM +0900, Masakazu Mokuno wrote:

> Here is a set of updates for PS3 gelic network driver.
> This patch set requires other patches which were already submitted by
> Geert (http://marc.info/?l=linux-kernel&m=119626095605487).
> 
> 	[1] PS3: gelic: Fix the wrong dev_id passed
> 	[2] PS3: gelic: Add endianness macros
> 	[3] PS3: gelic: Code cleanup
> 	[4] PS3: gelic: Remove duplicated ethtool handers
> 	[5] PS3: gelic: Add support for port link status
> 	[6] PS3: gelic: Add support for dual network interface
> 
> This is also a set of prerequisite for new wireless driver for PS3, which
> I'll submit later. 

These seem to not have been applied, but I couldn't find any stated
reason.  Did they just get lost?  Withdrawn?

Will these be applied?  There is a wireless patch that depends on them.
If not, will the wireless portion be refactored to not require these
patches?

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
