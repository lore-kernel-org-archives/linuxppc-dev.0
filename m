Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <200402161059.i1GAxDqA002613@ms.usish.com>
References: <200402161059.i1GAxDqA002613@ms.usish.com>
Mime-Version: 1.0 (Apple Message framework v612)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1FF3FFE3-609F-11D8-A367-000393A47A5C@lanl.gov>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Greg Watson <gwatson@lanl.gov>
Subject: Re: Sandpoint problems
Date: Mon, 16 Feb 2004 09:42:35 -0700
To: "Jack Liu" <Jack_liu@usish.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The sandpoint has at least two (sometimes three) flash parts. The one
containing DINK is on the PCI bus on the motherboard. One or two other
flash parts are on the PrMC card connected to the local memory bus. It
is normal to leave DINK alone and program one of the other flash parts
with an alternate boot loader. There are a series of dip switches that
switch between programming and booting from the various flash parts.
Unfortunately the documentation for the switch positions is very
confusing and unless you get it exactly right the board will not boot.
The best document I've found describing this is Application Note AN2487
"Configuring Motorola PrMC Cards". You can get this from the Motorola
web site.

Greg

On Feb 16, 2004, at 3:59 AM, Jack Liu wrote:

>
> Wolfgang Denk:
>    Sorry about this mess.
>   ======= 2004-02-16 10:35:00 Origianl message=======
>
>> In message <200402160051.i1G0pKqA003808@ms.usish.com> you wrote:
>>>
>>>   I am planning to use U-Boot to replace DINK13 shipped in
>>> Sandpoint platform. I got a sucessful compilation by: Make
>>> Sandpoint8245_config, Make all . Then I Burn u_boot.src in the Boot
>>> ROM. IT CAN'T BOOT. I used all default setting in the PrPMC8245 and
>>> Sandpoint board. I didn't know the reason. Anybody knows?
>>
>> First, this is off topic on the linuxppc-embedded list. Please send
>> U-Boot related questions to the u-boot-users list. Thanks.
>
>   Sorry about this mess.
>
>> What exactly did you do? "I Burn u_boot.src"? There is no file
>> u_boot.src. Do you mean u_boot.srec? Note that this is a S-Record file
>> - are you sure you need to use the S-record file?
>
>  I used u_boot.srec. To program flash, it will first be converted to
> binary file.
>
>> Where exactly in flash did you program it? How did you verify that the
>> flash programming worked?
>
>  I loaded u_boot in the bootrom of sandpoint board. And the same method
> was used on DINK.
>
>> And what exactly do you mean by "it can't boot"? (An why are you
>> shouting?) Is the board completely dead? Is there Some output? Which?
>> Does U-Boot run, but fails to boot Linux? Or what?
>
>     PCI LED on the board is active continuously.Yet no output. u-boot
> can not boot. Did I miss anything?
>
> = = = = = = = = = = = = = = = = = = = =
>
> Best regards
> Jack
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
