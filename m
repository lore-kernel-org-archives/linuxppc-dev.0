Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8CF9BDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 10 Dec 2007 03:47:03 +1100 (EST)
Received: from [206.223.20.150] (helo=hp-dhlii.dlasys.net)
	by mx.dlasys.net with esmtp (Exim 4.67 #1 (Debian))
	id 1J1P8H-0002a1-CV
	for <linuxppc-embedded@ozlabs.org>; Sun, 09 Dec 2007 11:35:57 -0500
Message-ID: <475C1AB9.5040005@dlasys.net>
Date: Sun, 09 Dec 2007 11:41:29 -0500
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
CC: linuxppc-embedded@ozlabs.org
Subject: Re: Kernel symbol version history
References: <4756CF15.2090805@dlasys.net>
	<200712051807.36357.jcd@tribudubois.net>
In-Reply-To: <200712051807.36357.jcd@tribudubois.net>
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

    Thank you.

       I made use of one of the linux cross reference sites.
       Though unless I don't know how to effectively use them trying to
track the history of a function, typdef, define, ..
       is not particularly easy using lxr.

       Grant's sugestion with git was closer to what I was looking for -
except that in some instances 
    needed to go back farther than it would take me..


Jean-Christophe Dubois wrote:
> Hi David,
>
> You could try the various "linux cross reference" web site out there. It is 
> not necessarily complete (some linux version might be missing)  but it can be 
> usefull to lookup if some symbols/define/typedef were available in a 
> particular Linux version.
>
> Have a look there.
>
> http://free-electrons.com/community/kernel/lxr
>
> Regards
>
> JC
>
> On Wednesday 05 December 2007 17:17:25 David H. Lynch Jr. wrote:
>   
>>     This might be slightly OT here, but would anyone know where there
>> might be a reference that indicates at precisely what version a given
>> symbol either appeared or disappeared within the  Linux kernel ?
>>
>>      As an example if a driver is supposed to work for 2.6 and 2.4 and
>> uses sysfs, or cdev, or alloc_chr_dev_region or ...
>>     How can one tell at what point that api or symbol appeared so that
>> the proper conditionals appear within the driver.
>>
>>     The last one that bit me was I made a collection of casting changes
>> to address 64bit vs. 32bit targets, and found that using the C99 fixed
>> size types - uint32_t, ... made life much more pleasant, after putting
>> them I nobody else could build because uintptr_t did not appear until
>> 2.6.24, and I still have not figured out exactly when uint32_t etc.
>> appeared.
>>
>>     I would think there ought to be some resource besides group memory
>> to look this up ?
>>     Is there a way to use git to look back through the history of a
>> symbol rather than a file.
>>     
>
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
