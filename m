Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 0320867A8C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 18:23:00 +1100 (EST)
In-Reply-To: <1110925103.5937.107.camel@ad.doubleclick.net>
References: <1110907039.24673.12.camel@rhino.az.mvista.com>
	<1110915063.5937.93.camel@ad.doubleclick.net>
	<583185c11becaca3ce73e4010c18154d@freescale.com>
	<1110925103.5937.107.camel@ad.doubleclick.net>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <dfbb0a3397338a3abfc2f93450311b9b@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 16 Mar 2005 01:22:48 -0600
To: "Jason McMullan" <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: 440EP FPU patch
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Jason,

Is it possible to make this against a newer tree (like a current bk 
pull).  The patch doesn't apply cleanly against head.S, which I'm 
guessing is due to the SPRN changes pushed upstream recently.

If I can apply it cleanly, I will get it pushed upstream.

- kumar

On Mar 15, 2005, at 4:18 PM, Jason McMullan wrote:

> On Tue, 2005-03-15 at 15:09 -0600, Kumar Gala wrote:
>> 1. Change config option to CONFIG_PPC_FPU
>> 2. split out altivec support into a separate file, most likely just
>> move it into vector.S
>> 3. Get ride of the C++ comments
>
> Changes made, as per your suggestions, and new patch attached.
>
> -- 
> Jason McMullan <jason.mcmullan@timesys.com>
> TimeSys Corporation
>
> <cpu-ppc-fpu.patch>
