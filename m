Return-Path: <diggskevin38@gmail.com>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D2F4BB7106
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 04:20:33 +1100 (EST)
Received: by iwb12 with SMTP id 12so1186364iwb.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 09:20:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1296016338.2349.125.camel@pasglop>
References: <AANLkTikJ8V-gQv93HBDH3=4o51vY5xyxQojqEV7DqNj=@mail.gmail.com>
	<1296016338.2349.125.camel@pasglop>
Date: Wed, 26 Jan 2011 11:20:29 -0600
Message-ID: <AANLkTim7gDwj+xCxiiTka23eu=v7kZX+Pq=3sQ1FT49J@mail.gmail.com>
Subject: Re: 750gx cpufreq induced kernel panic in 2.6.36
From: kevin diggs <diggskevin38@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 25, 2011 at 10:32 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>>
>> What are exception 700 & 901?
>
> 700 is a program check (illegal instruction or BUG_ON() statement)
>
> 900 is decrementer (aka timer) interrupt.
>
>> The 0x1000c694 address looks fishy?
>
> That's userspace.
>
> So you took a timer interrupt, which got into hrtimer, and something you
> did caused cpufreq_notify_transition to crash, probably with a BUG_ON

This should prove quite useful! Thanks!

> (which you can probably see above what you pasted, unless you don't have
> access to that part of the backtrace).
>
This is kind of my problem. ANY suggestions (applicable to an old
world PowerMac) would be appreciated on how to get access to the rest
of the information. This thing appears completely dead at this point.

Thanks!

kevin

P.S.:  There are 2 columns of numbers:

[xxx] [yyy]

One of these is the PC. What is the other? stack?

> Cheers,
> Ben.
>
>> Thanks!
>>
>> kevin
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
