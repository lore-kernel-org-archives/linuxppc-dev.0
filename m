Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B4E1DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Feb 2008 13:21:09 +1100 (EST)
Message-Id: <BA5ADBDE-BDE5-4126-B012-DA6C5A8F8EF3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Marco Stornelli <marco.stornelli@coritel.it>
In-Reply-To: <47BC51B5.50204@coritel.it>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: MPC8641D PCI-Express error
Date: Wed, 20 Feb 2008 20:20:56 -0600
References: <47BC51B5.50204@coritel.it>
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


On Feb 20, 2008, at 10:13 AM, Marco Stornelli wrote:

> Kumar Gala wrote:
>>> Marco Stornelli wrote:
>>>
>>>> No, but I can try to backport the PCI-E code from 2.6.24 to 2.6.18
>>>> if it could help. What do you think about it? Do you think this
>>>> problem could be not present in 2.6.24?
>>>> I have no idea there, honestly.  Sorry.
>
>> As Jon said, try 2.6.24 and see if it has an issue, if so we can look
>> at helping.  if not, you know you need to back port the fixes.
>
>> - k
>
> I've "backported" the PCI-Express code from 2.6.24 to 2.6.18, but it
> still doesn't work, I have the same problem (sigh), could you give me
> any suggestions?

did 2.6.24 work for you or not?

- k
