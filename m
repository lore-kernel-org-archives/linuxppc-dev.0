Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 451F6DDE24
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Oct 2007 09:38:41 +1000 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: mpc 860 boot linux2.6.23 problem
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 15 Oct 2007 12:17:00 CDT."
	<4713A08C.3060204@freescale.com>
Date: Tue, 16 Oct 2007 01:38:39 +0200
Sender: wd@denx.de
Message-Id: <20071015233839.959F4247BB@gemini.denx.de>
Cc: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <4713A08C.3060204@freescale.com> you wrote:
> keng_629 wrote:
> >  
> > i am proting linux2.63.23 to mpc860t board with uboot1.1.4 as bootloader.
> > my bootargs is root=/dev/ram rw init=/linuxrc.
> > i use debugger to see the regedits, find pc is run in the cpu_idle().
> > what is wrong with my kernel, plese give me some advice.thank you .
> 
> Posting the same thing over and over again isn't going to change the 
> response.  Try head-of-Linus's-git, make sure you're using arch/powerpc, 
> and post the device tree you're using.  Without more information, we 
> can't help you.

Just to point out the obvious: U-Boot 1.1.4 is *way* too old to
support any device-tree based kernel, so the fist step is to update
U-Boot to a somewhat recent version (i. e. 1.3.0-rcX).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Faith: not *wanting* to know what is true."    - Friedrich Nietzsche
