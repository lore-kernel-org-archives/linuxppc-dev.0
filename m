Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D5D97DDE39
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 15:40:31 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JAHsa-0004H7-CZ
	for linuxppc-dev@ozlabs.org; Wed, 02 Jan 2008 20:40:28 -0800
Message-ID: <14591612.post@talk.nabble.com>
Date: Wed, 2 Jan 2008 20:40:28 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: How to creat a .config file for a driver and How to use it in
	adevice driver?????
In-Reply-To: <477BCE30.8010306@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <14576412.post@talk.nabble.com> <477BCE30.8010306@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Ya i got your point ...the way you told is the very generic way of doing this
but what i need is this :-

Like your any .config if you edit your configuration and restart your
default configuration changes ....The merit of this technique is that i need
not compile the driver with every default config change ....

---Misbah <><

Sean MacLennan-2 wrote:
> 
> Misbah khan wrote:
>> Hi all ...
>>
>> i am writing a device driver in which the default configuration for LCD
>> display i need to keep it in a .config file so that as the system boots
>> it
>> take the value from this file and does the initial configuration in the
>> init
>> of the driver. If user changes the .config file content in the next boot
>> the
>> LCD driver should take the new default configuration 
>>
>> There will also be a run time config which could be changed at the rum
>> time
>> but will not change the default configuration.
>>
>>
>> i am writing a LCD driver for PPC arch i need to know that how should i
>> creat a .config file and How should i use it my device driver. ??????
>>
>> If you had an exprience in this regard please do share with me ...
>>
>> ----Misbah <><
>>   
> You don't. The safe way is to have sane defaults in the driver. Then 
> write a user mode app that reads the config file and configures the 
> driver properly, probably through ioctls.
> 
> Cheers,
>     Sean
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
> 

-- 
View this message in context: http://www.nabble.com/How-to-creat-a-.config-file-for-a-driver-and-How-to-use-it-in-a-device-driver------tp14576412p14591612.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
