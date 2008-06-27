Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2A61DDE08D
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:53:22 +1000 (EST)
Message-ID: <4864FECF.3010304@freescale.com>
Date: Fri, 27 Jun 2008 09:53:03 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, Jon Loeliger <jdl@freescale.com>,
	linuxppc-dev@ozlabs.org, Benno Rice <benno@jeamland.net>
Subject: Re: dtc: Address an assortment of portability problems
References: <20080626010349.GH308@yookeroo.seuss>
	<20080626152528.GA12256@loki.buserror.net>
	<20080626234743.GA16169@yookeroo.seuss>
In-Reply-To: <20080626234743.GA16169@yookeroo.seuss>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Thu, Jun 26, 2008 at 10:25:28AM -0500, Scott Wood wrote:
>> On Thu, Jun 26, 2008 at 11:03:49AM +1000, David Gibson wrote:
>>> 	- the endian handling functions in libfdt_env.h, based on
>>> endian.h and byteswap.h are replaced with some portable open-coded
>>> versions.  Unfortunately, these result in fairly crappy code when
>>> compiled, but as far as I can determine there doesn't seem to be any
>>> POSIX, SUS or de facto standard way of determining endianness at
>>> compile time, nor standard names for byteswapping functions.
>> Since device-tree and network byte order happen to be the same, we could use
>> ntohl/htonl.
> 
> Not for the 64-bit version.

Why?  They operate on uint32_t despite the "l" in the name, and there 
are no 64-bit fields in the device tree...

-Scott
