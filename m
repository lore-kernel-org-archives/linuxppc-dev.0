Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 63A1ADDDFB
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:37:56 +1100 (EST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 13 Mar 2007 08:12:14 +0100."
	<1173769934.24454.67.camel@localhost.localdomain>
Date: Tue, 13 Mar 2007 10:37:54 +0100
Sender: wd@denx.de
Message-Id: <20070313093754.4DE90353A9E@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Ben,

in message <1173769934.24454.67.camel@localhost.localdomain> you wrote:
>
>  - It's arch/ppc. We shouldn't do new major features on this codebase.
> You are welcome however in helping moving over 4xx to arch/powerpc :-)

Will do that as soon as we have an arch/powerpc port for the 440SP /
440SPe

>  - You only adapted head_4xx.S but the config option is global to all of
> arch/ppc, thus changing it will probably break everything else. Make

You are probably right. We will try to clean this up.

>  - Have you tried other page sizes ? How hard would it be to support 16K
> and what kind of performance numbers do you get with 16K ? It's a better

16 kB should work, but was not tested so far. From our RAID oriented
calculations it's not interesting.

We tried 256 kB, but kernel linking fails with a "Not enough room for
program headers" error message. We will investigate this ASAP, but at
the moment we have other priorities. [Any hints what might  go  wrong
are welcome.]

> compromise for some applications as 64K causes significant bloat of the
> page cache (among other things).

Agreed, but this obviously depends  on  the  sort  of  application(s)
you're running.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I'd like to meet the man who invented sex and see what  he's  working
on now.
