Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9F66DE16E
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 04:51:12 +1100 (EST)
Date: Thu, 13 Dec 2007 10:48:40 -0600
From: Scott Wood <scottwood@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH/RFC] CPM1: implement GPIO API
Message-ID: <20071213164840.GA4347@loki.buserror.net>
References: <47600F5E.8060907@scram.de> <200712122316.34354.arnd@arndb.de>
	<20071213005345.GA1577@zarina>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213005345.GA1577@zarina>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 13, 2007 at 03:53:45AM +0300, Anton Vorontsov wrote:
> No. This is how gpio api is working currently. With gpiolib[1], most of
> these functions will be controller-specific. IIRC, gpiolib is still in
> early development stage, so, for now, we have to limit us to one gpio
> chip controller.
> 
> This works great for us: CPM, CPM2 and QE shouldn't appear on the single
> crystal.

But at least the latter two should be able to co-exist in a single kernel
image...  Oh well, all we can do is hope the saner API makes it in soon. :-)

-Scott
