Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 537C6DDD08
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 Jul 2007 13:59:56 +1000 (EST)
Message-ID: <4696F81F.2040200@dlasys.net>
Date: Thu, 12 Jul 2007 23:57:19 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: TEMAC MAC address
References: <3D99384DA1D6124CBE9EE993BAA0E5B70195FDFD@exbe-dak-01.daktronics.lan>
	<fa686aa40707111311i42ed56bdiff24d2680b4a8297@mail.gmail.com>
In-Reply-To: <fa686aa40707111311i42ed56bdiff24d2680b4a8297@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Cc: Kevin Holland <KHollan@daktronics.com>,
	Linux PPC Linux PPC <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 7/11/07, Kevin Holland <KHollan@daktronics.com> wrote:
>   
>> Grant,
>>  How do I set the MAC address?
>>     
>
> Badly, with an ugly hack.  :-)
>
>   
>> When my ML410 board boots its Hardware
>> address is set to 0.  I looked through the message boards and can't seem
>> to find what Im looking for.  Thanks for your help.
>>     
>
> I set the mac addr with some Virtex specific code in
> arch/ppc/boot/simple/embed_config.c.
>
> BTW, Please at least CC: the mailing list when asking questions.
>   

Pico cards pass the MAC address to linux via the board info struct -
doesn't uboot etc.
have a similar facility ?

Pico registered a block of MAC addresses, uses them as card serial
numbers and passes them via
board info.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
