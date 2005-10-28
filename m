Return-Path: <typedef@eircom.net>
Received: from eurodubx.europlex.local (mail.europlex.ie [83.141.76.10])
	by ozlabs.org (Postfix) with ESMTP id 1C92E68613
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Oct 2005 06:42:04 +1000 (EST)
Message-ID: <43628EAA.6080409@eircom.net>
Date: Fri, 28 Oct 2005 21:48:42 +0100
From: Bryan O'Donoghue <typedef@eircom.net>
MIME-Version: 1.0
To: Peter Hanson <peterh@google.com>
References: <1628E43D99629C46988BE46087A3FBB93ADEE3@ep-01.EmbeddedPlanet.local>
	<50e923300510281227i15609c9dt7778ecbe20920dfa@mail.google.com>
In-Reply-To: <50e923300510281227i15609c9dt7778ecbe20920dfa@mail.google.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Steven Blakeslee <BlakesleeS@embeddedplanet.com>,
	linuxppc-embedded@ozlabs.org
Subject: Re: Howto Cross Compile GCC to run on PPC Platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Peter Hanson wrote:
> On 10/28/05, Steven Blakeslee <BlakesleeS@embeddedplanet.com> wrote:
> 
>>>get it to cross compile gcc (to run on ppc).  Does anyone
>>>know of a good HowTo to do this?
>>
>>Karim Yaghmour's "Building Embedded Linux Systems"
>>
>>
>>
>>> I'm currently downloading the source distro of ELDK, so if
>>>it's already in there I'll find it, but if there is one
>>>elsewhere online please let me know.
>>
>>Very good, full of features.
> 
> 
> My favorite cross tool chain site:
> 
> Building and Testing gcc/glibc cross toolchains
> http://kegel.com/crosstool/
> 
> Look into Canadian crosses.  At the very least you should find the
> discussion helpful.

I'd use the ELDK if I were you as an x86 hosted cross compiler, if only 
because it makes sense in terms of compiling bootloader & kernel with 
the same toolchain. Also, if memory serves the ELDK comes with a powerpc 
gcc in the supplied ppc root file system.

Alternatively : you can use the uClibc toolchain, to generate a similar 
setup.

Here's a script I've thrown together since I sometimes need to generate 
gcc toolchains easily for various targets. I've tested it with arm and 
powerpc and because, it might be useful to switch between c libraries. ymmv.
http://netsoc.dit.ie/~deckard/software/build_compiler.sh. This script is 
based on some excellent documents that Red Hat produced.

http://sources.redhat.com/ml/crossgcc/2005-08/msg00114/l-cross-ltr.pdf

-- 
"Caveat Emptor" -- James T. Kirk, in no such episode
