Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 62A9BDDE33
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Mar 2008 01:47:17 +1100 (EST)
To: Steve Heflin <sheflin@newagemicro.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Sequoia build with KDBG
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 29 Feb 2008 21:55:51 EST."
	<20080301025528.AE450DDE98@ozlabs.org>
Date: Sun, 02 Mar 2008 15:47:13 +0100
Sender: wd@denx.de
Message-Id: <20080302144713.C327A247B3@gemini.denx.de>
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

In message <20080301025528.AE450DDE98@ozlabs.org> you wrote:
>
> thank you so much for your helpful reply. No, I don't have a serial 
> port that works "out of the box", and your hint of setting up the MMU 
> translations and poking characters at hard coded addresses, is a big help.

Also remember that you can often get a lot of useful information from
a post-mortem dump of the lug buffer - see
http://www.denx.de/wiki/view/DULG/LinuxPostMortemAnalysis

Finally a wild guess - did you include a "-b 0" option when compiling
your device tree?

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Anyone who isn't confused here doesn't really know what's going on.
