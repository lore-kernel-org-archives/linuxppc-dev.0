Return-Path: <rodolfo@lesc.ufc.br>
Received: from lesc0.lesc.ufc.br (unknown [200.17.37.126])
	by ozlabs.org (Postfix) with ESMTP id 5ADE6DDED8
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 May 2008 21:46:22 +1000 (EST)
MIME-Version: 1.0
Date: Thu, 8 May 2008 08:46:17 -0300
From: rodolfo <rodolfo@lesc.ufc.br>
To: Detlev Zundel <dzu@denx.de>
Subject: Re: Predefined Compiler Flag for CROSS_COMPILE in ELDK
In-Reply-To: <m2tzhjxorq.fsf@ohwell.denx.de>
References: <m2tzhjxorq.fsf@ohwell.denx.de>
Message-ID: <8b6b0af3278e2fe8a9355b1e053e1419@lesc.ufc.br>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Detlev,

-mcpu is deprecated:

HOSTCC  scripts/basic/fixdep
`-mcpu=' is deprecated. Use `-mtune=' or '-march=' instead.
scripts/basic/fixdep.c:1: error: bad value (405) for -mtune= switch
make[1]: ** [scripts/basic/fixdep] Erro 1
make: ** [scripts_basic] Erro 2


then I put -march=405 and give this errors:

scripts/basic/fixdep.c:1: error: bad value (405) for -march= switch
scripts/basic/fixdep.c:1: error: bad value (405) for -mtune= switch
make[1]: ** [scripts/basic/fixdep] Erro 1
make: ** [scripts_basic] Erro 2

See a piece of my Makefile:

HOSTCC       = gcc
HOSTCXX      = g++
HOSTCFLAGS   = -Wall -Wstrict-prototypes -O2 -fomit-frame-pointer
-march=405
HOSTCXXFLAGS = -O2


How can I do this?

Thanks,


On Wed, 30 Apr 2008 18:59:05 +0200, Detlev Zundel <dzu@denx.de> wrote:
> Hi Rodolfo,
> 
>> I using ppc_4xx- cross-compiler for build linux in xup virtex II pro.
>> How can I change -mpcu compiler flag for a specific vallue for my
>> board/processor?
> 
> Do the obvious thing - specify it on every command line.
> 
> Cheers
>   Detlev
> 
> --
> "Oh, didn't you know, the Lord did the original programming of the
> universe in
> COBOL." - "That's why the world is the evil work of Satan. A true divine
> being
> would have used Scheme."  -  "And, if so, Jesus would have been crucified
> on a
> big lambda symbol."  -- K. Chafin, K. Schilling & D. Hanley, on
> comp.lang.lisp
> --
> DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
