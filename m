Return-Path: <dhlii@picocomputing.net>
Received: from outbound-mail-125.bluehost.com (outbound-mail-125.bluehost.com
	[67.222.38.25]) by ozlabs.org (Postfix) with SMTP id D8CE4DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 Apr 2008 11:56:52 +1000 (EST)
Message-ID: <480FE762.8060403@picocomputing.net>
Date: Wed, 23 Apr 2008 21:50:26 -0400
From: "David H. Lynch Jr." <dhlii@picocomputing.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: simpleboot
References: <480F8148.8090906@picocomputing.net>	
	<fa686aa40804231149j344a4cc5iaf15ac12828146f7@mail.gmail.com>	
	<480F917F.8040809@picocomputing.net>
	<fa686aa40804231248s162479d9o530051d3c88da471@mail.gmail.com>
In-Reply-To: <fa686aa40804231248s162479d9o530051d3c88da471@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> Its whatever kind of image you pass it.
>
>   
The simpleboot stuff must have hit Linux's tree today.
I synced with it.
created an arch/powerpc/boot/dts/pico_e1x.dts that is probably fouled up
- but that is a problem for later.

did:
make -f Makefile ARCH=powerpc   CROSS_COMPILE=powerpc-linux-uclibc-
simpleImage.pico_e1x

had to deal with a few different config options and then got:

make[1]: Entering directory `/usr/src/linux-2.6.pico'
make[1]: *** No rule to make target `simpleImage.pico_e1x'.  Stop.
make[1]: Leaving directory `/usr/src/linux-2.6.pico'
make: *** [release] Error 2

So how does the top level Makefile know about  the simpeImage.% target
in  arch/powerpc/boot ?






-- 
Dave Lynch                                          Pico Computing, Inc.
Software Development                                      Embedded Linux
717.627.3770      dhlii@picocomputing.net   http://www.picocomputing.com
fax: 1.253.369.9244                                 Cell: 1.717.587.7774
Tiny Mighty Machines
