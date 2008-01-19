Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 27A2BDDDEE
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 20 Jan 2008 03:19:22 +1100 (EST)
Message-Id: <823F3BC7-FF4E-4DA7-B000-9C128016ACB3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: vb <vb@vsbe.com>
In-Reply-To: <f608b67d0801181044j352ee94dl50ea291164f4cb17@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: MPIC ISU
Date: Sat, 19 Jan 2008 10:19:12 -0600
References: <f608b67d0801152203j523ebdeavbab4412121a31a7@mail.gmail.com>
	<57351E05-13DE-48F0-B0E5-28AADEF288A1@kernel.crashing.org>
	<f608b67d0801181044j352ee94dl50ea291164f4cb17@mail.gmail.com>
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


On Jan 18, 2008, at 12:44 PM, vb wrote:

> Kumar,
>
> thank you for your reply!
>
> On Jan 18, 2008 7:54 AM, Kumar Gala <galak@kernel.crashing.org> wrote:
>>
>>>
>>> What is it, at the very least - what does ISU stand for?
>>>
>>> I would really appreciate any hints,
>>
>> Interrupt service unit.  I believe its an IBM concept.
>>
>> For 8245 can you look at what the linkstation port is doing and mimic
>> that.  I believe its an 8245 or 8241 so it should be close to what  
>> you
>> need.
>>
>
> what platform is linkstation and what kernel version can I find it in?

arch/powerpc/platforms/embedded6xx/linkstation.c

you should be able to find it 2.6.23 or newer.

- k
