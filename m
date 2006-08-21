Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 57F9767BB9
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 06:15:53 +1000 (EST)
In-Reply-To: <1156189170.11326.56.camel@basalt.austin.ibm.com>
References: <Pine.LNX.4.61.0608211427330.12614@ld0175-tx32.am.freescale.net>
	<1156189170.11326.56.camel@basalt.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9D51268F-606B-4CB0-B01A-EDF480B00ED2@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Fix FEC node in 8540 ADS dts
Date: Mon, 21 Aug 2006 15:15:39 -0500
To: Hollis Blanchard <hollis@penguinppc.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2006, at 14:39, Hollis Blanchard wrote:

> On Mon, 2006-08-21 at 14:29 -0500, Andy Fleming wrote:
>>
>> diff --git a/arch/powerpc/boot/dts/mpc8540ads.dts
>> b/arch/powerpc/boot/dts/mpc8540ads.dts
>> index 93d2c2d..5f41c1f 100644
>> --- a/arch/powerpc/boot/dts/mpc8540ads.dts
>> +++ b/arch/powerpc/boot/dts/mpc8540ads.dts
>> @@ -83,11 +83,11 @@
>>                                 reg = <1>;
>>                                 device_type = "ethernet-phy";
>>                         };
>> -                       ethernet-phy@2 {
>> -                               linux,phandle = <2452002>;
>> +                       ethernet-phy@3 {
>> +                               linux,phandle = <2452003>;
>
> Again, doesn't DTC assign linux,phandle properties as needed (i.e.  
> when
> the node is referenced with & syntax)?


That's what I hear.  I think this would be a good place for using  
that, but I'm waiting for someone to determine whether some sort of  
labeling system is going to be added, first.  As it doesn't require  
changes to u-boot or linux, it's an easy fix for a later time.

I will, of course, accede to popular opinion.  But I'd rather change  
all the phandles in exactly the same way, and I feel that the  
notation gets clunky when seen iterated in a table (as shown in Jon's  
patch for that change).

Andy
