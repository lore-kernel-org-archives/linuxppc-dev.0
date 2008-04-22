Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 75964DE02E
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 23:27:37 +1000 (EST)
In-Reply-To: <20080422055536.GI20457@bakeyournoodle.com>
References: <767e424a294239aba86aa7da086f6395f7066d14.1208834828.git.tony@bakeyournoodle.com>
	<20080422135005.16b4a65d.sfr@canb.auug.org.au>
	<20080422055536.GI20457@bakeyournoodle.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <60054bf8803cb8f2a447c604447c6ae6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/3] Raise the upper limit of NR_CPUS.
Date: Tue, 22 Apr 2008 15:27:06 +0200
To: tony@bakeyournoodle.com (Tony Breeds)
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Paul Mackerras <paulus@samba.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	unsigned long kernel_toc = (unsigned long)(&__toc_start) + 
>>> 0x8000UL;
>>
>> This line could do with a comment saying what it is doing ...
>
> It does need a comment I agree, but I don't think I can do it justice 
> :)
> ... I just used what was already there.

Here, have one:

"The TOC register (GPR2) points 32kB into the TOC, so that 64kB
of the TOC can be addressed using a single machine instruction."

or, perhaps simpler:

"The TOC register (GPR2) points 32kB into the TOC, because the
ABI says so."


Segher
