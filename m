Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4A9BBDDEB7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Jul 2007 00:59:43 +1000 (EST)
Message-ID: <469F7C54.60509@freescale.com>
Date: Thu, 19 Jul 2007 09:59:32 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 56/61] 82xx: Add pq2fads board support.
References: <20070718013615.GB15238@ld0162-tx32.am.freescale.net>
	<200707190154.55368.arnd@arndb.de>
In-Reply-To: <200707190154.55368.arnd@arndb.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 18 July 2007, Scott Wood wrote:
> 
>>+static void __init pq2fads_setup_arch(void)
>>+{
>>+	struct device_node *np;
>>+	struct resource r;
>>+	u32 *bcsr;
> 
> 
> bcsr should be __iomem, right?

Oops, yes.

> Did you run your code through sparse?

No, installing sparse is still on my to-do list.  I guess I should raise 
its priority. :-)

-Scott
