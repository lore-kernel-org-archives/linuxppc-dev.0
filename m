Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 455B3DDE30
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  1 Dec 2007 09:15:57 +1100 (EST)
To: fabien <fabien.fb@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: ppcboot and powerpc branch question
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Nov 2007 14:33:38 +0100."
	<f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com>
Date: Fri, 30 Nov 2007 23:15:54 +0100
Sender: wd@denx.de
Message-Id: <20071130221554.3AA0124075@gemini.denx.de>
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

In message <f8f856500711300533t3bad1c1dxb4ff137534acbccb@mail.gmail.com> you wrote:
> 
> instead of bd_t struct. I'm a bit disappointed because i also see that
> older u-boot (in my case
> ppcboot 1.1.5) aren't capable to pass dts to kernel.

PPCBoot was a in a distant  past  before  U-Boot.  Actually,  PPCBoot
1.1.5 is more than 5 and a half years old. You cannot really expect a
Neanderthal man to drive a space shuttle.

> Is there a way to keep my old bootloader to boot a powerpc branch kernel ?

No. Please use a current U-Boot (i. e. at least U-Boot 1.3.0).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
As in certain cults it is possible to kill a process if you know  its
true name.                      -- Ken Thompson and Dennis M. Ritchie
