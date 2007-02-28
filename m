Return-Path: <dan@embeddedalley.com>
Received: from smtp107.biz.mail.re2.yahoo.com (smtp107.biz.mail.re2.yahoo.com
	[206.190.52.176]) by ozlabs.org (Postfix) with SMTP id 3AADEDDE31
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Mar 2007 02:46:58 +1100 (EST)
In-Reply-To: <511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>
References: <45E46976.6060600@freescale.com>
	<29c13109971547687159078eacdea008@kernel.crashing.org>
	<45E592DC.9060700@freescale.com>
	<511cacb7bbe8a65ff72738c84ec9ece4@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <BD465924-7387-47EF-B90F-606F215819C2@embeddedalley.com>
From: Dan Malek <dan@embeddedalley.com>
Subject: Re: lanana: Add major/minor entries for PPC QE UART devices
Date: Wed, 28 Feb 2007 10:46:53 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: Torben.Mathiasen@hp.com, linux-ppc-embedded <linuxppc-embedded@ozlabs.org>,
	Timur Tabi <timur@freescale.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Feb 28, 2007, at 9:54 AM, Segher Boessenkool wrote:

>>>>           46 = /dev/ttyCPM0        PPC CPM (SCC or SMC) - port 0
>>>>              ...
>>>> -         47 = /dev/ttyCPM5        PPC CPM (SCC or SMC) - port 5
>>>> +         49 = /dev/ttyCPM5        PPC CPM (SCC or SMC) - port 5
>>> If CPM0 is 46, then CPM5 is not 47, but not 49 either.
>>> Unless it's not CPM5 but CPM3?
>>
>> Honestly, I don't know.  I was just correcting the obvious typo (47
>> instead of 49).
>
> It's obvious it shouldn't be 47, but it's not obvious it
> should be 49 instead.

I don't know the origin of this thread, but none of
that looks correct.  Today, there can be up to 8
CPM UART devices, 6 on CPM/CPM2 and 8
on the QE.  If ttyCPM0 starts at minor 46, they
should be at least monotonically incrementing
up to ttyCPM7 with minor 53.


Thanks.

	-- Dan
