Return-Path: <artunmurat@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.189])
	by ozlabs.org (Postfix) with ESMTP id F1768DDE39
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 18:28:54 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id c10so122502nfd
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 01:28:53 -0700 (PDT)
Message-ID: <4e5a3720709190128o7bfa3ef0rb5d9d4ccd0bfd9a4@mail.gmail.com>
Date: Wed, 19 Sep 2007 11:28:52 +0300
From: "Murat Artun" <artunmurat@gmail.com>
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: cross compiling a library with ELDK
In-Reply-To: <20070918224126.48196247FE@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <4e5a3720709180602g20ccc060hbf7f091839a18c99@mail.gmail.com>
	<20070918224126.48196247FE@gemini.denx.de>
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

Wolfgang,

Thanks for your response...

I confess I did not read the whole documentation from scratch, but I
have browsed many sections especially related with my issue. I should
say it is always said in documentation that setting $CROSS_COMPILE
environment variable is necessary, but that did not work for me.

Specifically, I am trying to cross compile osip library with EDLK (not
an ELDK component). When I execute the configure script I want the
config.h to be generated to reflect the target system. As from your
last response I understand that I always need to make sure by checking
config.h file myself.

After I have posted this problem I found the below thread:

http://ozlabs.org/pipermail/linuxppc-embedded/2003-July/011785.html

Following the same, I have achieved generation of config.h by checking
ELDK components and GNU cross tools to be prefixed with ppc_8xx.

Although I was not able to build shared libraries with the generated
makefile, building static libraries was OK. But it seems as if it is
somehow difficult to cross build a SW component that is not a part of
ELDK, and this is harder than "Rebuilding ELDK Components" which is
specified to be so straightforward in the documentation.

Thanks and regards...

On 9/19/07, Wolfgang Denk <wd@denx.de> wrote:
> In message <4e5a3720709180602g20ccc060hbf7f091839a18c99@mail.gmail.com> you wrote:
> >
> > I want to cross compile a free software library with ELDK 3.1.1 for
> > powerpc. I have ELDK installed under directory /opt and my system and
> > PATH is set properly. I have a few points to be clarified:
>
> May I recommend that, as a first step, you read the documentation?
>
> > - For a cross compilation with ELDK how can we be sure that config.h
> > file for a software packet is generated properly? I mean, how can we
>
> You cannot be sure. You will always have to check.
>
> > be sure that ELDK components is checked instead of our host linux
> > system for generating a config.h file by the configure script?
>
> RTFM. See especially the two bullets at
> http://www.denx.de/wiki/view/DULG/ELDKRebuildingComponents#Section_3.7.2.
>
> Best regards,
>
> Wolfgang Denk
>
> --
> DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
> HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
> Wisdom is one of the few things that looks bigger the further away it
> is.                               - Terry Pratchett, _Witches Abroad_
>


-- 
M u r at  A r t u n, MSc.
   Design Engineer

"be conservative in what you do, be liberal in what you accept from others"
