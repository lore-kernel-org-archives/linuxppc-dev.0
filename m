Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id F07DB6889F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 07:55:58 +1100 (EST)
To: Robin Mathew <robbinmathew@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 Dec 2005 20:44:27 +0530."
	<5b74ec4d0512180714r178223f6ub60df08a7ef78fc9@mail.gmail.com>
Date: Sun, 18 Dec 2005 21:55:55 +0100
Sender: wd@denx.de
Message-Id: <20051218205555.ADF2A352B33@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: x86 gdb with ppc8xx gdbserver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Robin,

in message <5b74ec4d0512180714r178223f6ub60df08a7ef78fc9@mail.gmail.com> you wrote:
> 
> But I am not able to compile gdb in x86 for ppc8xx target. Can you please
> point to some source tree of gdb that can be compiled for x86 platform for
> ppc8xx target? I tried with gdb version 6.4 but it does not take

Since you've been successful with the ELDK binaries,  why  not  using
the  ELDK  sources? Either the SRPM from the ELDK source distribution
(which gives you 5.2.1), or from the CVS,  which  has  the  (not  yet
released) ELDK 4.0 code (= 6.3.0)

> --target=ppc8xx option. I think the option that I am using to compile for
> target is not right.

Indeed, it is wrong. There is no such target architecture as "ppc8xx".

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
For every complex problem, there is a solution that is simple,  neat,
and wrong.                                           -- H. L. Mencken
