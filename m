Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.varma-el.com",
	Issuer "mail.varma-el.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D66A9679F6
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 23:05:37 +1100 (EST)
Date: Fri, 31 Mar 2006 15:41:04 +0400
From: Andrey Volkov <avolkov@varma-el.com>
Message-ID: <884202836.20060331154104@varma-el.com>
To: bennett78 <bennett78@digis.net>
Subject: Re: Bestcomm Firmware update
In-Reply-To: <442C5A75.7030107@digis.net>
References: <442C5A75.7030107@digis.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sylvain Munaut <tnt@246tNt.com>, linuxppc-embedded@ozlabs.org
Reply-To: Andrey Volkov <avolkov@varma-el.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Frank.

On Friday, March 31, 2006, bennett78 wrote:

> SoSoComm Dudes:

VERY, VERY BIG thanks to you :-))), finally we can do something more
sensible with it (like scatter-gather).

>   I was able to contact Davide Santo, AN2604 "Introduction to BestComm".
> He admitted
> the short commings of his document in the area of Firmware instruction
> info and gave
> me a name of a guy, Ed in the ASIC design area in Austin.  Ed has agreed
> to answer
> questions, push for resources to provide a support tool and provided me
> with a document
> from their head programmer "SmartDMA Hand-Assembly Guides" (see attached
> pdf).

> With this secret decoded ring I was able to put together a disassembler,
> see attached
> disasm.c. Cut and paste your favorite Task into fw[] array at the 
> beginning,
> "cc -o d disasm.c ; d"  It's not perfect, but useful- Enjoy.  Sorry I'm not
> sure where or if you guys want to check this stuff into a git 
> repository, somewhere
> and hope ozlabs is not fussy about attachments!
But it could be start point for a kernel compiler :).

> If we can formulate a list of questions Ed might be able to help, I'll
> start:
>     o what does init=31 mean?
>        AN2604 say init=0 means always requestor and 31 is reserved but
> referenced
>        alot in the F/W comments
>     o Need more info on how MORE works
>     o Tell us about LCD levels. Only 2? (let's call a LCD indent a level)
>       LCD seems to reset DRD to 1A. DRD2B1or2 follow a DRD2A (ext=1)?
>     o LCD[28:23]orLCD[20:15] or LCD[11:6] what is extraN?
>         drop 101nnn - extraN
>         add  1nnnnn - indexN
>     o how many DRD2B1[2] can be stacked up?
>     o when is/can a LDC Literal used? and how?
I'll reread my drafts at next week too, so may be this list will be
extended.

-- 
Regards,
Andrey Volkov
