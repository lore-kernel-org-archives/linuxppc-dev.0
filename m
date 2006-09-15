Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.213.223.res-cmts.eph.ptd.net
	[24.152.213.223]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0CF6E67B5F
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Sep 2006 11:20:32 +1000 (EST)
Message-ID: <4509FF01.6030903@dlasys.net>
Date: Thu, 14 Sep 2006 21:16:49 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: wei.li4@elf.mcgill.ca
Subject: Re: Uncompressing Linux failure
References: <20060914141550.b4x2d2aqck48osk4@webmail.mcgill.ca>
In-Reply-To: <20060914141550.b4x2d2aqck48osk4@webmail.mcgill.ca>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

    This looks like the ppc bug with new version of zlib.
But I thought it was fixed by 2.6.18-rc2.

MY recomendation would be to either move newer or older.
Alternatively back out the zlib patch.

wei.li4@elf.mcgill.ca wrote:
> Hi All,
>
> I got the following error when I ported linux 2.6.18-rc2-g73a589b5 to 
> my board(MPC875), my bootloader is working fine with linux 2.6.13, and 
> I am using same cross-tools from ELDK 4.0:
>
> loaded at:     00400000 00529124
> board data at: 00FFFEA8 00FFFF2C
> relocated to:  00404068 004040EC
> zimage at:     00404EE1 00526337
> avail ram:     0052A000 01000000
>                                                                         
>          Uncompressing Linux...inflate returned FFFFFFFE
> exit
>
> Can you advise me? thanks.
>
> Wei
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
