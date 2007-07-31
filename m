Return-Path: <ma.harounansari@gdatech.co.in>
Received: from gdatech.co.in (mail.gdatech.co.in [202.144.30.226])
	by ozlabs.org (Postfix) with ESMTP id B2F92DDDF9
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 17:10:21 +1000 (EST)
Received: from [192.168.0.2] (localhost.localdomain [127.0.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id 1394E878093
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 00:10:08 -0700 (PDT)
Received: from mail.gdatech.co.in (unknown [192.168.0.1])
	by predator.gdatech.co.in (Postfix-out) with ESMTP id C3EC187806E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jul 2007 00:10:07 -0700 (PDT)
Message-ID: <007001c7d341$d3ae29d0$9503a8c0@Ansari>
From: "Ansari" <ma.harounansari@gdatech.co.in>
To: "Kumar Gala" <galak@kernel.crashing.org>
References: <000801c7cf51$f98ebb90$9503a8c0@Ansari>
	<880B302A-742A-4CC1-BB41-E7BD1CE570C6@kernel.crashing.org>
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)
Date: Tue, 31 Jul 2007 12:40:07 +0530
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=response
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

Hi Kumar,

First of all thanks for ur reply .

Even i went through the linux source . And i have observe that the reboot 
command used to hard reset the core . I have few doubts can u please clarify 
me.

1. Is there any way to reset the full chip with out using any external 
signal (MPC8560) ? (like any register that can be used for reseting the 
processor)
2. Even same reboot command works fine for MPC8540 Processor ?.
3. what are the factors that makes ramdisk hangs . When its uncompressing ?

Regards
Haroun Ansari


----- Original Message ----- 
From: "Kumar Gala" <galak@kernel.crashing.org>
To: "Ansari" <ma.harounansari@gdatech.co.in>
Cc: <linuxppc-embedded@ozlabs.org>
Sent: Friday, July 27, 2007 1:21 AM
Subject: Re: Reboot Command Makes kernel to hang (MPC8560)


>
> On Jul 26, 2007, at 1:55 AM, Ansari wrote:
>
>> Hi all,
>>
>> Processor (MPC8560)
>>
>> Whenever reboot command is given in the linux console. The  processor 
>> gets reset and it loads bootloader , kernel and when  uncompressing the 
>> ramdisk it gets hang. The sample log is given  below. Any u please tell 
>> me what are the factors that can makes  this to happen.
>
> This is very board dependant.  The MPC8560 doesn't have a clean way  to 
> request reset, and odds are you're only getting the core reset and  not 
> the full chip.
>
> - k
> 
