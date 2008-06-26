Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B05E6DEED9
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Jun 2008 01:26:17 +1000 (EST)
Date: Thu, 26 Jun 2008 10:25:28 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Loeliger <jdl@freescale.com>, linuxppc-dev@ozlabs.org,
	Benno Rice <benno@jeamland.net>
Subject: Re: dtc: Address an assortment of portability problems
Message-ID: <20080626152528.GA12256@loki.buserror.net>
References: <20080626010349.GH308@yookeroo.seuss>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080626010349.GH308@yookeroo.seuss>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 26, 2008 at 11:03:49AM +1000, David Gibson wrote:
> 	- the endian handling functions in libfdt_env.h, based on
> endian.h and byteswap.h are replaced with some portable open-coded
> versions.  Unfortunately, these result in fairly crappy code when
> compiled, but as far as I can determine there doesn't seem to be any
> POSIX, SUS or de facto standard way of determining endianness at
> compile time, nor standard names for byteswapping functions.

Since device-tree and network byte order happen to be the same, we could use
ntohl/htonl.

-Scott
