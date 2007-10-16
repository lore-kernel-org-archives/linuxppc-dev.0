Return-Path: <Tom.Ziomek@motorola.com>
Received: from mail153.messagelabs.com (mail153.messagelabs.com
	[216.82.253.51]) by ozlabs.org (Postfix) with SMTP id 210B2DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 06:12:28 +1000 (EST)
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (8.12.11/Motorola) with ESMTP id l9GKCQsc013056
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 13:12:26 -0700 (MST)
Received: from il06vts04.mot.com (il06vts04.mot.com [129.188.137.144])
	by il06exr02.mot.com (8.13.1/Vontu) with SMTP id l9GKCP0i017950
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 15:12:25 -0500 (CDT)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by il06exr02.mot.com (8.13.1/8.13.0) with ESMTP id l9GKCPDN017941
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 15:12:25 -0500 (CDT)
Date: Tue, 16 Oct 2007 15:12:24 -0500 (CDT)
From: T Ziomek <ctz001@email.mot.com>
To: aauer1 <aauer1@gmx.at>
Subject: Re: Linux booting problem on Xilinx ppc
In-Reply-To: <fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0710161511280.22843@gauley.ddna.labs.mot.com>
References: <12694083.post@talk.nabble.com>
	<fa686aa40709152009k2b27ffc9kfb3fd0848f6b16d@mail.gmail.com>
	<12696686.post@talk.nabble.com> <13219154.post@talk.nabble.com>
	<000901c81006$7303b490$bb3ca688@LGE.NET>
	<13239003.post@talk.nabble.com>
	<fa686aa40710161237t54688b71g9c7cf9acdac2b744@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

On Tue, 16 Oct 2007, Grant Likely wrote:
>
> On 10/16/07, aauer1 <aauer1@gmx.at> wrote:
>>
>> The on-chip memories are disabled. Only the BRAM is enabled. Now, we also use
>> the ELDK 4.1 from Denx and the included cross compiler. The result is the
>> same... the Kernel stops at "Now booting the kernel". Now, we also have an
>> USB JTAG cable. So, we can debug the memory.
>> Probably, anyone has another idea.
>
> There are two common reasons for this behaviour:
> 1. kernel crashes before the console is configured
> 2. the console is not configured correctly.
>
> In both cases; finding a way to look at __log_buf is the fastest way
> to figure out what is going on.

Woah.  Grant's [good] advise notwithstanding, I'm confused

-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
