Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2B97BDDF7F
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 26 Mar 2007 05:39:52 +1000 (EST)
To: "Ken Sakurai" <sakurken@gmail.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: AVNET 440GX board 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 23 Mar 2007 16:30:50 EST."
	<393e3a4b0703231430n65b01a79jaff5942004405aa4@mail.gmail.com>
Date: Sun, 25 Mar 2007 21:39:50 +0200
Sender: wd@denx.de
Message-Id: <20070325193950.4B73A35264E@atlas.denx.de>
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

In message <393e3a4b0703231430n65b01a79jaff5942004405aa4@mail.gmail.com> you wrote:
> 
> I found that the bootelf command actually jumped to _start(), and then
> stoped inside load_kernel()@arch/ppc/boot/simple/misc.c.  Because of
> stupid debugging method, just slow progress.

You waste your efforts. You use the wrong image format (ELF instead of
uImage] and the wrong boot command [bootelf instead of bootm].

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Punishment becomes ineffective after a certain point. Men become  in-
sensitive.
	-- Eneg, "Patterns of Force", stardate 2534.7
