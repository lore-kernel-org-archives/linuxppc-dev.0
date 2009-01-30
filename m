Return-Path: <mike_timmons@trimble.com>
Received: from snvl-smtp1.trimble.com (snvl-smtp1.trimble.com [155.63.64.31])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "snvl-smtp1.trimble.com", Issuer "Trimble CA" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6D117DE21A
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 08:40:07 +1100 (EST)
Message-ID: <498373AD.5040107@trimble.com>
Date: Fri, 30 Jan 2009 15:39:57 -0600
From: Mike Timmons <mike_timmons@trimble.com>
MIME-Version: 1.0
To: Grant Erickson <gerickson@nuovations.com>
Subject: Re: toolchain for building linux-2.6.27.8 or 2.6.28.1  AND USB wi
	fi SUCCESS...
References: <C5A7544F.14345%gerickson@nuovations.com>
In-Reply-To: <C5A7544F.14345%gerickson@nuovations.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org
Reply-To: mike_timmons@trimble.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thank You! I obtained ELDK 4.1 from Denx and built 2.6.27.8 with it. A 
couple host tool links were required but the build was pretty painless.

Ultimate goal I startedon early in the week was USB wi fi using the 
Linksys WUSB54GC, which requires the ralink rt73 driver.

The 2.6.27.8 menuconfig offered the "firmware" loading options I was 
looking for.

I now have a working USB wi fi device.

THANK YOU!

-Mike Timmons

Grant Erickson wrote:
> On 1/29/09 11:52 AM, Mike Timmons wrote:
>   
>> Questions:
>> 1) if I want to cross-compile a kernel later than 2.6.24 to hopefully
>> get better WAN device support (and clearer options for fw loading),
>> which kernel should I try, and which toolchain?
>>
>> the ltib repository does not appear to have a toolchain newer than
>> gcc-3.4.3-glibc-2.3.6 (for 603e)
>>
>> Admissions, disclaimers, etc
>> 1) I'm using the same ltib script I have used for the 2.6.24 build with
>> toolchain gcc-3.4.3-glibc-2.3.6 (for 603e).
>> I'm simply modifying the kernel spec file to use 2.6.28.1 (and specifyin
>> a custom toolchain).
>> I've also tried to compile 2.6.27.8. I get the same error.
>>     
>
> Mike:
>
> Denx's ELDK 4.1 or 4.2 make a great "It Just Works" solution. I've used 4.1
> running from 2.6.23 up to 2.6.27.11 and 4.2 from 2.6.26 to 2.6.27.11 with
> zero problems or issues.
>
> Regards,
>
> Grant Erickson
>
>
>   
