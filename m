Return-Path: <anemo@mba.ocn.ne.jp>
Received: from smtp.mba.ocn.ne.jp (mba.ocn.ne.jp [122.1.235.107])
	by ozlabs.org (Postfix) with ESMTP id 08902DDE0A
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 02:44:53 +1000 (EST)
Date: Sat, 15 Sep 2007 01:09:40 +0900 (JST)
Message-Id: <20070915.010940.25476256.anemo@mba.ocn.ne.jp>
To: david@gibson.dropbear.id.au
Subject: Re: rtc-ds1742.c should use resource_size_t for base address
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070914055427.GM481@localhost.localdomain>
References: <20070914055427.GM481@localhost.localdomain>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	rtc-linux@googlegroups.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 14 Sep 2007 15:54:27 +1000, David Gibson <david@gibson.dropbear.id.au> wrote:
> Currently the rtc driver, rtc-ds1742.c uses an unsigned long to store
> the base mmio address of the NVRAM/RTC.  This breaks on systems like
> PowerPC 440, which is a 32-bit core with 36-bit physical addresses: IO
> on the system, including the RTC, is typically above the 4GB point,
> and cannot fit into an unsigned long.
> 
> This patch fixes the problem by replacing the unsigned long with a
> resource_size_t.  Tested on Ebony (PPC440) (with additional patches to
> instantiate the ds1742 platform device appropriately).
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Thanks!

Acked-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
