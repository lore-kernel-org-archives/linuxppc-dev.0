Return-Path: <linux@sundmangroup.com>
Received: from proxy3.bredband.net (proxy3.bredband.net [195.54.101.73])
	by ozlabs.org (Postfix) with ESMTP id 658C4DDEEE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Jan 2008 04:47:26 +1100 (EST)
Received: from ironport2.bredband.com (195.54.101.122) by proxy3.bredband.net
	(7.3.127) id 473103E701759B33 for linuxppc-embedded@ozlabs.org;
	Tue, 15 Jan 2008 18:47:24 +0100
Message-ID: <478CF1A9.3070102@sundmangroup.com>
Date: Tue, 15 Jan 2008 18:47:21 +0100
From: Matias Sundman <linux@sundmangroup.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: PPC vs POWERPC
References: <23145.147.11.3.128.1200054808.squirrel@www.sundmangroup.com>	
	<fa686aa40801110652s67b2a05al79f78144c5b527bd@mail.gmail.com>	
	<478C8D38.3090602@sundmangroup.com>
	<1200416484.14540.5.camel@ld0161-tx32>
In-Reply-To: <1200416484.14540.5.camel@ld0161-tx32>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jon Loeliger skrev:
> On Tue, 2008-01-15 at 04:38, Matias Sundman wrote:
>   
>>  >>Documentation/powerpc/booting-without-of.txt to find out what is
>>  >>expected in the device tree.
>>
>> Is there any more information on how the "of_*" ( e.g. of_node_put ,  
>> of_find_node_by_type ) functions should be implemented in  the 
>> "arch/powerpc/platforms/myplatform/myboard_setup.c" file
>> or is the documentation the existing "*.c" c files under 
>> arch/powerpc/platforms ?
>>
>> Since I have a 82xx board I assume that "myboard_setup.c" file shall be 
>> put under arch/powerpc/platforms/82xx.
>>     
>
> Maybe.  Which 82xx is it?  There is a notable difference
> between, say, the 824x boards and the 827x boards.  If it
> is the latter, perhaps the existing 82xx/ pq2 or mpc8272
> parts are already sufficient?
>
> If it is the former group, 824x, perhaps some of the parts
> in embedded6xx/ are usable?  Also note that I am working on
> publishing an 824x StorCenter port under embedded6xx/ at
> this time as well.  First patches were posted to linuxppc-dev
> list at ozlabs.org.
>
> HTH,
> jdl
>
>
>   
The board is based on PPC8265.

Cheers // Matias
