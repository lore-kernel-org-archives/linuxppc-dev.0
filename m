Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 3D7F667A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 04:58:02 +1100 (EST)
Message-ID: <4239C51B.70101@mvista.com>
Date: Thu, 17 Mar 2005 10:57:47 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
References: <42323A97.5070105@mvista.com>
	<20050317163526.GB10864@wohnheim.fh-wedel.de>
In-Reply-To: <20050317163526.GB10864@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-mtd@lists.infradead.org, dwmw2@infradead.org,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 2.6.12] mtd: Remove MTD map file for Chestnut platform.
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jörn Engel wrote:

>On Fri, 11 March 2005 17:40:55 -0700, Mark A. Greer wrote:
>  
>
>>Remove Chestnut mtd map file.
>>
>>The chestnut now sets up its MTD map from its platform-specific file so 
>>the map file drivers/mtd/maps/chestnut.c is no longer needed.  This 
>>patch removes the file & the Kconfig/Makefile hooks.
>>
>>Please apply.
>>    
>>
>
>Applied to mtd cvs.  It will make its way to Linus eventually...
>
>Thanks!
>  
>

Jörn,

Thanks for looking into this but Andrew has already pushed that through 
from his end.  (I had posted an earler patch with the map removal in it 
before I broke it out and sent that part to you and the rest to Andrew 
again.)

Sorry for wasting your time.

Mark
