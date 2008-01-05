Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 2CFB1DDEBC
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 05:32:50 +1100 (EST)
Message-ID: <477FCD51.5020902@pikatech.com>
Date: Sat, 05 Jan 2008 13:32:49 -0500
From: Sean MacLennan <smaclennan@pikatech.com>
MIME-Version: 1.0
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] i2c-ibm_iic driver
References: <477EF225.4070505@pikatech.com> <200801051224.52693.arnd@arndb.de>
	<200801051349.34488.sr@denx.de>
In-Reply-To: <200801051349.34488.sr@denx.de>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stefan Roese wrote:
>
>> Otherwise, there are two options: 
>>
>> 1. duplicate the driver like you suggested
>> 2. make the same driver both a ocp and of_platform, depending on
>> the configuration options.
>>
>> Since most of the driver is untouched by your patch, I'd lean to
>> the second option, but of course, that is more work for you.
>>     
>
> I did send a patch for such a combined driver a few months ago:
>
> http://patchwork.ozlabs.org/linuxppc/patch?person=305&id=14181
>
> There were still same open issues and I didn't find the time till now to 
> address them. It would be great if you could take care of these issues and 
> submit a reworked version.
>
>   
I can look into this. Thanks!

Cheers,
   Sean
