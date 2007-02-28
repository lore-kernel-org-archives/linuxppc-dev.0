Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-01.arcor-online.net (mail-in-01.arcor-online.net
	[151.189.21.41])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 70EDADDE16
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 01:54:47 +1100 (EST)
In-Reply-To: <45E592DC.9060700@freescale.com>
References: <45E46976.6060600@freescale.com>
	<29c13109971547687159078eacdea008@kernel.crashing.org>
	<45E592DC.9060700@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Wed, 28 Feb 2007 15:54:37 +0100
To: Timur Tabi <timur@freescale.com>
Cc: Torben.Mathiasen@hp.com,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>>>           46 = /dev/ttyCPM0        PPC CPM (SCC or SMC) - port 0
>>>              ...
>>> -         47 = /dev/ttyCPM5        PPC CPM (SCC or SMC) - port 5
>>> +         49 = /dev/ttyCPM5        PPC CPM (SCC or SMC) - port 5
>> If CPM0 is 46, then CPM5 is not 47, but not 49 either.
>> Unless it's not CPM5 but CPM3?
>
> Honestly, I don't know.  I was just correcting the obvious typo (47 
> instead of 49).

It's obvious it shouldn't be 47, but it's not obvious it
should be 49 instead.

> I'll try to get an answer from someone, but I'm no CPM expert.

Adding linuxppc-embedded to the CC:, someone there surely knows.


Segher
