Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id E5BE967B16
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Apr 2006 22:03:51 +1000 (EST)
Message-ID: <003601c65d5f$f8e43720$5800000a@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Howard, Marc" <Marc.Howard@KLA-Tencor.com>
References: <91B22F93A880FA48879475E134D6F0BE026CD163@CA1EXCLV02.adcorp.kla-tencor.com><443B0718.3050001@ovro.caltech.edu><91B22F93A880FA48879475E134D6F0BE386FBC@CA1EXCLV02.adcorp.kla-tencor.com><443B1EE9.5030104@ovro.caltech.edu><91B22F93A880FA48879475E134D6F0BE386FBD@CA1EXCLV02.adcorp.kla-tencor.com>
	<443B27E6.8070607@ovro.caltech.edu>
Subject: Re: Create permanent mapping from PCI bus to region of physical memory
Date: Tue, 11 Apr 2006 08:03:37 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
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

> You always have the hack of reserving a block of memory
> at the top of SDRAM, i.e., lie to Linux and tell it it
> has less memory. It sounds like that might be the least
> effort. Rubini has an example of how to do that.
> 

I've done this with a bus-master PCI peripheral and it works
nicely.  The other point about this is that the mmap() call
will work rationally with memory above the linux pool, so
it's easy to go straight to/from user land with this approach.
(and you can set caching and the guard bit and all that so
that PPC access works the way you want it to)

Mark Chambers
