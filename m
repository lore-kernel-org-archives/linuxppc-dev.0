Return-Path: <linville@tuxdriver.com>
Received: from ra.tuxdriver.com (ra.tuxdriver.com [70.61.120.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0533D67BC1
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Sep 2006 23:17:04 +1000 (EST)
Date: Thu, 7 Sep 2006 09:16:35 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Chun Chung Lo <cclo@astri.org>
Subject: Re: Wireless Linux(802.11) for Embedded PowerPC
Message-ID: <20060907131630.GA784@tuxdriver.com>
References: <A7B1E4DD46AA7046A4398F745240F29402737D68@ASPROEXG.astri.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A7B1E4DD46AA7046A4398F745240F29402737D68@ASPROEXG.astri.local>
Cc: wei.li4@elf.mcgill.ca, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Sep 07, 2006 at 09:23:08AM +0800, Chun Chung Lo wrote:

> Also I cannot see any drivers existing in the upstream kernel are really
> support the "Intersil Prism 2 WLAN" cards (my card is differ from those
> Orinoco cards and Hermes cards, also the drivers are also differ a lot).

I think you may be mistaken.  The orinoco drivers in the upstream
kernel seem to support all the same device IDs as are supported
in the linux-wlan code.  If your card is missing, it is likely a
simple matter of a missing device ID.  But, major code changes are
probably not necessary.  (USB-based devices may be an exception....see
http://www.nongnu.org/orinoco/ for experimental support.)
 
> If you are going to use Intersil Prism 2 cards/chips, I would suggest
> you to use the linux-wlan driver (but seems this driver does not support
> AP mode yet...)

Please don't encourage people to patronize dead projects when the
upstream kernel should work for them.

Thanks,

John
-- 
John W. Linville
linville@tuxdriver.com
