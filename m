Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0ABDA67A3D
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 06:34:41 +1000 (EST)
Message-ID: <44E38157.4070805@garzik.org>
Date: Wed, 16 Aug 2006 16:34:31 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/2]:  powerpc/cell spidernet bottom half
References: <20060811170337.GH10638@austin.ibm.com>
	<20060816161856.GD20551@austin.ibm.com>
	<44E34825.2020105@garzik.org>
	<20060816203043.GJ20551@austin.ibm.com>
In-Reply-To: <20060816203043.GJ20551@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: akpm@osdl.org, Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
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

Linas Vepstas wrote:
> I was under the impression that NAPI was for the receive side only.

That depends on the driver implementation.

	Jeff
