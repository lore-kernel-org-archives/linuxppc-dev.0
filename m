Return-Path: <markc@mail.com>
Received: from smtp1.us4.outblaze.com (smtp1.us4.outblaze.com [205.158.62.78])
	by ozlabs.org (Postfix) with SMTP id 438CD679FD
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 May 2006 00:17:29 +1000 (EST)
Message-ID: <001901c6704e$9e36a860$6601a8c0@CHUCK2>
From: "Mark Chambers" <markc@mail.com>
To: "Gautam Borad" <gautam@eisodus.com>,
	<linuxppc-embedded@ozlabs.org>
References: <20060505094007.0F169353AD3@atlas.denx.de>
	<445B5A98.8020004@eisodus.com>
Subject: Re: frequent sig 11 with malloc() on mpc8xx
Date: Fri, 5 May 2006 10:17:15 -0400
MIME-Version: 1.0
Content-Type: text/plain; format=flowed; charset="iso-8859-1";
	reply-type=original
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> We are aware that its a FAQ and we rechecked the SDRAM configuration,
> everything seems fine.
> We disabled burst mode and tried but that didnt help. Now we want to
> disable cache and check.

Another thing you can try on the 852 is to change the processor frequency
via the PLPRCR register.  If slowing down the clock helps, don't assume
that you have a timing problem though - these PLL circuits are notoriously
twitchy, and it could be noise (or, more properly, resonant frequencies in 
your
layout)

Mark Chambers

P.S. Hopefully you have a hardware debugger - you can halt the processor
and change this register on the fly.  Same with cache - no sense compiling
these changes, just do them manually. 
