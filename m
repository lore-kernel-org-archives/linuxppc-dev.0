Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A207F67B5E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Jul 2006 06:54:20 +1000 (EST)
In-Reply-To: <20060724120712.15709.qmail@web36606.mail.mud.yahoo.com>
References: <20060724120712.15709.qmail@web36606.mail.mud.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E7B9A429-DF2A-4E07-9A0D-C6726D6A9C98@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: stupid linker question.... to remove unused functions in the
	object file.
Date: Mon, 24 Jul 2006 15:54:25 -0500
To: Parav Pandit <paravpandit@yahoo.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I believe you can use -ffunction-sections -Wl,--gc-sections when you  
compile and link.  If you have binutils prior to 2.16, this only  
works with -static.

-B


On Jul 24, 2006, at 7:07 AM, Parav Pandit wrote:

> Hi,
>
> I have few functions in a C file but those are not
> called at present. Even though those function
> definitions are part of the object file.
> Those will be called later on.
>
> What CFLAGS should I pass to remove unused functions?
> I cannot enable -Ox at present to have any
> unpredictable behaviour.
>
> Regards,
> Parav Pandit
>
>
> --- Wade Maxfield <wmaxfield@gmail.com> wrote:
>
>> gcc -Wa,-alhs -g main.c >main.cs
>>
>>   will put interleaved code/assembly into main.cs
>> file.
>>
>> wade
>>
>>
>>
>> On 7/21/06, Steve Iribarne (GMail)
>> <netstv@gmail.com> wrote:
>>>
>>> I forgot the flag that generates a list file that
>> has both assembly
>>> and c mixed in.
>>>
>>> Anyone?
>>>
>>> Thanks...
>>>
>>> -stv
>>> _______________________________________________
>>> Linuxppc-embedded mailing list
>>> Linuxppc-embedded@ozlabs.org
>>>
>>
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>>>
>>> _______________________________________________
>> Linuxppc-embedded mailing list
>> Linuxppc-embedded@ozlabs.org
>>
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> __________________________________________________
> Do You Yahoo!?
> Tired of spam?  Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
