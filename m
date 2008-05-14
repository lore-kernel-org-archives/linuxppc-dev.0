Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-105.bluehost.com (outbound-mail-105.bluehost.com
	[69.89.18.5]) by ozlabs.org (Postfix) with SMTP id 3D830DDE0E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 14 May 2008 16:04:11 +1000 (EST)
Message-ID: <482A7F48.1030700@dlasys.net>
Date: Wed, 14 May 2008 01:57:28 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: ramkumarj2000@gmail.com
Subject: Re: Compiling applications using cross compiler packs libc
References: <4f8c3030805120212r730ded9dv23dfcc29119ebfe5@mail.gmail.com>
	<20080512102728.GA26806@mail.gnudd.com>
In-Reply-To: <20080512102728.GA26806@mail.gnudd.com>
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
Reply-To: dhlii@dlasys.net
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Alessandro Rubini wrote:
>> the glibc is also packed
>> up as a part of application though I never make any calls to the glibc
>> libraries.
>>     
>
> If however you really want to build an application without library, you
> should change the linker script. 
some or all of the following gcc flags might be useful if you are truly
compiling an OS independent very small application
-U__linux__
-nostdlib
-nostdinc
-mno-eabi
-fno-builtin
-nostartfiles
-nodefaultlibs
-nostdlib
Also as Alessandro pointed out you will likely need a link script.

-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
