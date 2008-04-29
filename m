Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-25.bluehost.com (outbound-mail-25.bluehost.com
	[69.89.21.20]) by ozlabs.org (Postfix) with SMTP id D8C9CDDF29
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Apr 2008 20:03:08 +1000 (EST)
Message-ID: <4816F0CF.2080800@dlasys.net>
Date: Tue, 29 Apr 2008 05:56:31 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: HAVE_CONFIG
References: <4816B372.10608@dlasys.net> <200804291127.14666.arnd@arndb.de>
In-Reply-To: <200804291127.14666.arnd@arndb.de>
Content-Type: text/plain; charset=iso-8859-1
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

Arnd Bergmann wrote:
> On Tuesday 29 April 2008, David H. Lynch Jr. wrote:
>   
>>     Why does CONFIG_PPC set CONFIG_HAVE_IDE ?
>>     
>
> Because it's possible to build ide drivers on the powerpc architecture.
> It means you get the option to enable to disable the old ATA (IDE) drivers.
>
> 	Arnd <><
>   
    So CONFIG_HAVE_IDE means the architecture could have IDE rather than
it does have IDE ?
   
    My BSP can't have IDE, does that mean I should add
   
    default n if MYBSP

    ? or somehow deselect HAVE_IDE in the config option for my BSP ?


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
