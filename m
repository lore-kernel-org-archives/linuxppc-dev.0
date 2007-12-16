Return-Path: <lethal@linux-sh.org>
Received: from mx.gate01.com (pip10.gyao.ne.jp [61.122.117.248])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33D70DDDF3
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Dec 2007 23:46:24 +1100 (EST)
Date: Sun, 16 Dec 2007 21:46:04 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 1/3] [libata] pata_platform: make probe and remove
	functions device type neutral
Message-ID: <20071216124604.GA12769@linux-sh.org>
References: <20071214182109.GA858@localhost.localdomain>
	<20071214182429.GA1017@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071214182429.GA1017@localhost.localdomain>
Cc: Jeff Garzik <jeff@garzik.org>, Arnd Bergmann <arnd@arndb.de>,
	linux-ide@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 14, 2007 at 09:24:29PM +0300, Anton Vorontsov wrote:
> Split pata_platform_{probe,remove} into two pieces:
> 1. pata_platform_{probe,remove} -- platform_device-dependant bits;
> 2. __ptata_platform_{probe,remove} -- device type neutral bits.
> 
> This is done to not duplicate code for the OF-platform driver.
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Olof Johansson <olof@lixom.net>

Looks fine to me now, thanks for cleaning it up Anton.

Acked-by: Paul Mundt <lethal@linux-sh.org>
