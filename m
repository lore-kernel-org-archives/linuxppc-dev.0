Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C7D26DDDD5
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Nov 2007 11:54:07 +1100 (EST)
To: "Jon Smirl" <jonsmirl@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 14 Nov 2007 21:34:45 EST."
	<9e4733910711141834n2bfb1742v5637c56e27e26f5a@mail.gmail.com>
Date: Sun, 18 Nov 2007 01:47:29 +0100
Sender: wd@denx.de
Message-Id: <20071118004729.67824247F1@gemini.denx.de>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <9e4733910711141834n2bfb1742v5637c56e27e26f5a@mail.gmail.com> you wrote:
>
> > * The documentation is only available under NDA, a problem for open
> > source debuggers.
> 
> This is what we need. I would like it specifically for the mpc5200.
> But we want to use it in OpenOCD so NDA won't work.

It doesn't work. Been  there  a  logn  time  ago.  It's  and  endless
fingerpointing.  Freescale  (by  then:  Motorola)  says  they  cannot
release any information because of their contracts with IBM, and vice
versa.

> Dominic is way experienced implementing JTAG for ARM CPUs. He has done
> several dozen interfaces. ARM doesn't have any problems releasing
> their debugging info.

JTAG is simple, but you don't get the necessery information for the
COP (= debug) interface.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Genius doesn't work on an assembly line basis.  You can't simply say,
"Today I will be brilliant."
	-- Kirk, "The Ultimate Computer", stardate 4731.3
