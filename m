Return-Path: <alohanono@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id C5D23DDD0C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Feb 2008 23:05:10 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1084639rnf.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 06 Feb 2008 04:05:09 -0800 (PST)
Message-ID: <47A9A26B.2010203@gmail.com>
Date: Wed, 06 Feb 2008 13:04:59 +0100
From: "A. Nolson" <alohanono@gmail.com>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problems booting in ML403
References: <47A8782E.4050402@gmail.com>
	<fa686aa40802050824y2a650231j3889b749d3553701@mail.gmail.com>
In-Reply-To: <fa686aa40802050824y2a650231j3889b749d3553701@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

It seems that the multiple "console=" parameters in the kernel were the 
problem. I have substituted for only

 console=ttyS0,9600 

Now I have managed to boot it completely.

Thank you!

Grant Likely wrote:
> On 2/5/08, A. Nolson <alohanono@gmail.com> wrote:
>   
>> Hello,
>>
>>  I am having problems while trying to boot my linux kernel 2.6.24-rc3 (
>> secretlab git). After some days studying this list and other related
>> documents/wikis about how to make work a linux kernel in my ML403, I
>> managed to make it work partially.
>>
>>     
> <snip>
>   
>> Linux/PPC load: console=ttyS0,9600 console=tty0,9600 console=ttyUL0,9600
>> root=/d
>> ev/xsa2 rw
>> init=/sbin/init
>>     
>
> What happens if you try init=/bin/sh?
>
> What does your /etc/inittab look like?
>
> It looks like the system is booting, but inittab might not be starting
> any processes attached to the serial console.
>
> Cheers,
> g.
>
>   
