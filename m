Return-Path: <tnt@246tNt.com>
Received: from outmx024.isp.belgacom.be (outmx024.isp.belgacom.be
	[195.238.4.128])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E07D6679EA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 31 Mar 2006 17:13:40 +1100 (EST)
Received: from outmx024.isp.belgacom.be (localhost [127.0.0.1])
	by outmx024.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k2V6DB1I028974
	for <linuxppc-embedded@ozlabs.org>; Fri, 31 Mar 2006 08:13:24 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <442CC847.2080207@246tNt.com>
Date: Fri, 31 Mar 2006 08:12:23 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: bennett78@digis.net
Subject: Re: Bestcomm Firmware update
References: <442C5A75.7030107@digis.net>
In-Reply-To: <442C5A75.7030107@digis.net>
Content-Type: text/plain; charset=ISO-8859-1
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

bennett78 wrote:
> SoSoComm Dudes:
>
>  I was able to contact Davide Santo, AN2604 "Introduction to
> BestComm". He admitted
> the short commings of his document in the area of Firmware instruction
> info and gave
> me a name of a guy, Ed in the ASIC design area in Austin.  Ed has
> agreed to answer
> questions, push for resources to provide a support tool and provided
> me with a document
> from their head programmer "SmartDMA Hand-Assembly Guides" (see
> attached pdf).
>

Great document ! At last some documentation ... Thanks very much !

> With this secret decoded ring I was able to put together a
> disassembler, see attached
> disasm.c. Cut and paste your favorite Task into fw[] array at the
> beginning,
> "cc -o d disasm.c ; d"  It's not perfect, but useful- Enjoy.  Sorry
> I'm not
> sure where or if you guys want to check this stuff into a git
> repository, somewhere
> and hope ozlabs is not fussy about attachments!
I can put it on line on a webserver. I guess Freescale gave you
permission to publish
this document ?

> If we can formulate a list of questions Ed might be able to help, I'll
> start:
>    o what does init=31 mean?
>       AN2604 say init=0 means always requestor and 31 is reserved but
> referenced
>       alot in the F/W comments
>    o Need more info on how MORE works
>    o Tell us about LCD levels. Only 2? (let's call a LCD indent a level)
>      LCD seems to reset DRD to 1A. DRD2B1or2 follow a DRD2A (ext=1)?
>    o LCD[28:23]orLCD[20:15] or LCD[11:6] what is extraN?
>        drop 101nnn - extraN
>        add  1nnnnn - indexN
>    o how many DRD2B1[2] can be stacked up?
>    o when is/can a LDC Literal used? and how?

I'll read the document more deeply this week end with the task code
beside me,
try to see if some things are still unclear.


    Sylvain
