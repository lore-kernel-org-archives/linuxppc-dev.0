Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCDBF67C53
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Aug 2006 02:39:34 +1000 (EST)
In-Reply-To: <1156444531.17977.59.camel@saruman.qstreams.net>
References: <1156371402.17977.21.camel@saruman.qstreams.net>
	<AB150E9C-6BB3-46C1-980D-311D3277BFC1@kernel.crashing.org>
	<1156430695.17977.28.camel@saruman.qstreams.net>
	<9861097B-ACAD-45E6-9FA7-B86F0C1E8FA1@kernel.crashing.org>
	<1156444531.17977.59.camel@saruman.qstreams.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DB2639AB-266C-460E-B8C2-C946A847640C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: CompactFlash on PQII Pro
Date: Fri, 25 Aug 2006 11:39:28 -0500
To: bwarren@qstreams.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 24, 2006, at 1:35 PM, Ben Warren wrote:

> Kumar,
>
> On Thu, 2006-08-24 at 13:25 -0500, Kumar Gala wrote:
>
>> The only code in u-boot was the UPM setup code, I'm happy to send
>> that to you.
>>
> If it's no trouble, that would be great.  My HW guy is calculating the
> settings, but this stuff can be frustrating to debug.  BTW - was the
> system bus speed for your CPU 33 or 66 MHz?  We're targeting for a
> 400MHz 8349 which has a 33MHz system bus.

I think we were running @ 66Mhz, but I've run the FSL ref board @ 33MHZ.

- k
