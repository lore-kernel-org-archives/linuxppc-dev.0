Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 06D84B707B
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 26 Jun 2009 03:34:35 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2C219DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jun 2009 03:34:33 +1000 (EST)
Message-Id: <4FA3B563-2881-4F9E-8B23-C36FB439BE2B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: kernel mailz <kernelmailz@googlemail.com>
In-Reply-To: <abe8a1fd0906250351y1aadc153m9f52f65a5860a2ca@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: 85xx Address space query
Date: Thu, 25 Jun 2009 12:32:22 -0500
References: <abe8a1fd0906240244i6e33c260xadff5cf462df7b8c@mail.gmail.com>
	<D47FC871-1535-4DBF-8617-6EEA8C180484@kernel.crashing.org>
	<abe8a1fd0906241046x2e3ee7d5h6a6c0231086a6f0e@mail.gmail.com>
	<4A42AE1A.1090107@freescale.com>
	<abe8a1fd0906250351y1aadc153m9f52f65a5860a2ca@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

That is correct.  The PID = 0 translations are always valid.

- k

On Jun 25, 2009, at 5:51 AM, kernel mailz wrote:

> So this means
> when kernel gets interrupted by app which may be in PID=5 (say)
> kernel translations for PID=0 remain valid ?
> I am not able to follow Scott
>
> -TZ
>
> On Thu, Jun 25, 2009 at 4:22 AM, Scott Wood<scottwood@freescale.com>  
> wrote:
>> kernel mailz wrote:
>>>
>>> But If the app was running with PID=1, interrupt occurs, kernel code
>>> gets executed in PID=1, how does the kernel handle this ? and goes
>>> back to PID=0, since its translations are all in PID=0
>>
>> PID 0 is special, it's mappings are present regardless of the value  
>> of the
>> PID register.
>>
>> -Scott
>>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
