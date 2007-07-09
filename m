Return-Path: <mark@mtfhpc.demon.co.uk>
Received: from anchor-post-30.mail.demon.net (anchor-post-30.mail.demon.net
	[194.217.242.88]) by ozlabs.org (Postfix) with ESMTP id A19D5DDD05
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 Jul 2007 00:33:45 +1000 (EST)
Date: Mon, 9 Jul 2007 15:33:05 +0100 (BST)
From: Mark Fortescue <mark@mtfhpc.demon.co.uk>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: ARCH=ppc vs ARCH=powerpc
In-Reply-To: <200707090234.14851.arnd@arndb.de>
Message-ID: <Pine.LNX.4.61.0707091528510.12823@mtfhpc.demon.co.uk>
References: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
	<200707090234.14851.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
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

Hi All,

I am currently trying to identify an anoying feature of linux on my 
sparc32 systems but I will do some work on the ppc -> powerpc migration 
as soon as I have exauhsted my current avenues of investiation on the 
sparc32 issue.

Regards
 	Mark Fortescue.

On Mon, 9 Jul 2007, Arnd Bergmann wrote:

> On Friday 06 July 2007, Mark Fortescue wrote:
>> For me, the requirement is to keep support for the cards indicated in
>> arch/ppc/config/xxx_defconfig (as I have one that I might what to use with
>> linux) in the same way as they are supported in ARCH=ppc.
>
> The one thing that is holding up the transition to arch/powerpc is lack
> of people with access to the respective boards. If you have one board
> that you care about, it would be good if you look into getting it moved
> over. Tell us if you have problems doing so. It shouldn't be all that
> hard any more, and if it is, maybe some documentation is missing.
>
>> I have just made some tweeks to get ARCH=ppc building for me but I still
>> need to sort out what is required to get around *** Error: Headers not
>> exportable for this architecture (ppc).
>
> You should simply install the headers with ARCH=powerc, even when the
> kernel is built with ARCH=ppc. From the user space point of view, there
> is only one set of headers.
>
> 	Arnd <><
>
