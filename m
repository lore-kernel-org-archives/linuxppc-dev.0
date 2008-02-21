Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id A6024DDEBB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 19:01:07 +1100 (EST)
Message-ID: <47BD3001.2020004@coritel.it>
Date: Thu, 21 Feb 2008 09:02:09 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8641D PCI-Express error
References: <47BC51B5.50204@coritel.it>
	<BA5ADBDE-BDE5-4126-B012-DA6C5A8F8EF3@kernel.crashing.org>
In-Reply-To: <BA5ADBDE-BDE5-4126-B012-DA6C5A8F8EF3@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala ha scritto:
> 
> On Feb 20, 2008, at 10:13 AM, Marco Stornelli wrote:
> 
>> Kumar Gala wrote:
>>>> Marco Stornelli wrote:
>>>>
>>>>> No, but I can try to backport the PCI-E code from 2.6.24 to 2.6.18
>>>>> if it could help. What do you think about it? Do you think this
>>>>> problem could be not present in 2.6.24?
>>>>> I have no idea there, honestly.  Sorry.
>>
>>> As Jon said, try 2.6.24 and see if it has an issue, if so we can look
>>> at helping.  if not, you know you need to back port the fixes.
>>
>>> - k
>>
>> I've "backported" the PCI-Express code from 2.6.24 to 2.6.18, but it
>> still doesn't work, I have the same problem (sigh), could you give me
>> any suggestions?
> 
> did 2.6.24 work for you or not?
> 
> - k
> 
No, it didn't. I have the same problem even with the 2.6.18 plus the
2.6.24 PCI-Express code. I performed this action because I can't change
kernel version but I can modify it.

Marco
