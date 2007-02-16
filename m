Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id B7E8ADDDE5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Feb 2007 08:19:37 +1100 (EST)
In-Reply-To: <200702162150.44997.arnd@arndb.de>
References: <32201137.34111171657512254.JavaMail.root@vms061.mailsrvcs.net>
	<E6C97B4B-F3DF-4AEC-A225-60DC6AE05691@freescale.com>
	<200702162150.44997.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <948DF54C-9D39-4C56-83C5-94F17D29EE1A@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: What happened to include/asm-ppc??
Date: Fri, 16 Feb 2007 15:19:28 -0600
To: Arnd Bergmann <arnd@arndb.de>
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


On Feb 16, 2007, at 14:50, Arnd Bergmann wrote:

> On Friday 16 February 2007 21:45, Andy Fleming wrote:
>>
>> They're probably in include/asm-powerpc/
>>
>> You'll need both, since there are still some files in asm-ppc that
>> are needed by the asm-powerpc stuff.
>
> That shouldn't be the case, the headers from asm-powerpc should be
> sufficient for all 32 and 64 bit user apps, if not then you should
> really report that as a bug.


I might be wrong.  But last I heard, there's a link between arch/ 
powerpc/include/asm and include/asm-ppc

And visa-versa.


>
> 	Arnd <><
