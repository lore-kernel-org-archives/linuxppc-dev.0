Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id F147467AC5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 16:14:31 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j366IVSP013378
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 6 Apr 2005 09:18:32 +0300 (EEST)
Message-ID: <42537BA8.9060104@intracom.gr>
Date: Wed, 06 Apr 2005 09:03:20 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B85933A@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B85933A@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: FCC Ethernet startup crash
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Rune Torgersen wrote:
>>From: Dan Malek [mailto:dan@embeddededge.com] 
>>On Apr 5, 2005, at 12:41 PM, Rune Torgersen wrote:
>>
>>
>>>Without calling fcc_restart in the start, I get lots of 
>>
>>"eth0: tx queue
>>
>>>full!." messages.
>>
>>Do you tftp boot your kernel using the boot rom?  Does the
>>boot rom disable the Ethernet before calling the kernel?
> 
> 
> Yes, I tftp the kernel, using U-Boot (1.1.2 CVS Head as of 11-20-04).
> Haven't looked at the code, but I think it disablesd the FCC Ethernets
> (Have seen discussions about htat on u-boot mailing list before)
> 

U-boot definately disables the ethernets. Or at least it must.

> The patch Stefan Nickl gave to me works perfectly, and all it does is
> basically move the fcc_restart.
> The kernel was still calling fcc_restart twiche per FCC at startup (one
> time on init_fcc_startup, and then again in fcc_open), now it just calls
> it twice in fcc_open. Seems to work.
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
> 
> 

Regards

Pantelis
