Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2A1AEDE388
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Mar 2008 03:19:59 +1100 (EST)
To: Scott Wood <scottwood@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2] 8xx: Add support for the MPC852 based board from
	keymile.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Mar 2008 10:11:32 EST."
	<20080318151132.GA17402@ld0162-tx32.am.freescale.net>
Date: Tue, 18 Mar 2008 17:19:57 +0100
Sender: wd@denx.de
Message-Id: <20080318161957.766A124349@gemini.denx.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Heiko Schocher <hs@denx.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Scott,

in message <20080318151132.GA17402@ld0162-tx32.am.freescale.net> you wrote:
>
> Well, the device tree is a mechanism for communicating from the firmware
> to the kernel, and if we could control the firmware better we'd just make
> it set the pins properly to begin with. :-)

Is this just a comment, or do you oppose Heiko's suggestion?

Other uses of the device tree seem possible and reasonable, too.  For
example, we can use the device tree to configure the firmware (U-Boot
in this case).

Using the device tree  to  describe  the  pin  configuration  of  the
hardware  sounds  easier to me than hard-coding it in some source (or
header) file - no matter if this is  in  the  kernel  and/or  in  the
firmware.

What do you think?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A quarrel is quickly settled when deserted by one party; there is  no
battle unless there be two.                                  - Seneca
