Return-Path: <wojciech.kromer@dgt.com.pl>
Received: from dgt.com.pl (mail.dgt.com.pl [195.117.141.2])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 442BC688EB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 21:30:42 +1100 (EST)
Received: from mail.dgt.com.pl (localhost [127.0.0.1])
	by dgt.com.pl (Postfix) with SMTP id A5B8B6A2C3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 11:30:29 +0100 (CET)
Received: from [192.168.7.66] (proxy.dgt.com.pl [::ffff:195.117.141.11])
	by dgt.com.pl (Postfix) with ESMTP id 3F4F86A2FB
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  9 Dec 2005 11:30:20 +0100 (CET)
Message-ID: <43995D8E.2050500@dgt.com.pl>
Date: Fri, 09 Dec 2005 11:33:50 +0100
From: Wojciech Kromer <wojciech.kromer@dgt.com.pl>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
References: <43817ACF.1030903@dgt.com.pl>
	<200511211243.13519.david.jander@protonic.nl>
In-Reply-To: <200511211243.13519.david.jander@protonic.nl>
Content-Type: text/plain; charset=iso-8859-2; format=flowed
Subject: Re: Strange results with changing HZ
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dnia 2005-11-21 12:43, U¿ytkownik David Jander napisa³:

>On Monday 21 November 2005 08:44, Wojciech Kromer wrote:
>  
>
>>My system is:
>> - 2.4.25 kernel from denx.de
>> - uclibc (gcc 3.4.2) + busybox
>> - changed HZ to 1000
>> - rebuild kernel only
>>
>>AFAIR there souldn't be any need to recompile user apps.
>>    
>>
>
>Just an uneducated guess, but are you sure uclibc doesn't depend on HZ at all?
>Some things might be just straight syscalls, others might be implemented in 
>userspace (inside uclibc)... for example alarm(1) programming an alarm on 
>jiffies+1/HZ, and HZ being compiled in from kernel headers ?
>I may just be talking rubbish though.
>  
>

Hmm, after recompiling whole uclibc stuff it seem to work same.
There should be kernel problem. Sleep & select works fine, but alarm 
works 10 times faster.

Anyone tries to change HZ to 1000?
