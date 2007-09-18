Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id EBD00DDE38
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 19 Sep 2007 08:41:27 +1000 (EST)
To: "Murat Artun" <artunmurat@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: cross compiling a library with ELDK
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Sep 2007 16:02:27 +0300."
	<4e5a3720709180602g20ccc060hbf7f091839a18c99@mail.gmail.com>
Date: Wed, 19 Sep 2007 00:41:26 +0200
Sender: wd@denx.de
Message-Id: <20070918224126.48196247FE@gemini.denx.de>
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

In message <4e5a3720709180602g20ccc060hbf7f091839a18c99@mail.gmail.com> you wrote:
> 
> I want to cross compile a free software library with ELDK 3.1.1 for
> powerpc. I have ELDK installed under directory /opt and my system and
> PATH is set properly. I have a few points to be clarified:

May I recommend that, as a first step, you read the documentation?

> - For a cross compilation with ELDK how can we be sure that config.h
> file for a software packet is generated properly? I mean, how can we

You cannot be sure. You will always have to check.

> be sure that ELDK components is checked instead of our host linux
> system for generating a config.h file by the configure script?

RTFM. See especially the two bullets at
http://www.denx.de/wiki/view/DULG/ELDKRebuildingComponents#Section_3.7.2.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Wisdom is one of the few things that looks bigger the further away it
is.                               - Terry Pratchett, _Witches Abroad_
