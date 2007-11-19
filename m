Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id E472EDDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 08:13:49 +1100 (EST)
To: Clemens Koller <clemens.koller@anagramm.de>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Problem with uboot on lite5200
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 Nov 2007 14:21:55 +0100."
	<47403C73.9040506@anagramm.de>
Date: Mon, 19 Nov 2007 22:13:47 +0100
Sender: wd@denx.de
Message-Id: <20071119211347.575522479C@gemini.denx.de>
Cc: Leo Hendrawan <leo.hendrawan@gmail.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <47403C73.9040506@anagramm.de> you wrote:
> 
> How should people get a glue what's current, when in the section
> "Latest News" at http://sourceforge.net/projects/u-boot/ the people
> still find a more or less official looking "u-boot-1.1.5" release.

Maybe by reading the very first two lines on the SF page:

	...
        NOTE: current source code is available from DENX git
        repository and FTP server; see http://www.denx.de/en/Software/GIT

or by looking at the project page http://u-boot.sourceforge.net/ which
redirects you to http://www.denx.de/wiki/UBoot which has all the
significant information?

The problem is that you cannot really "shut down" a SourceForge
project (please correct me if I'm wrong).

> (And they don't want to use scm repositories because they are afraid
> of using anything unstable.)

I guess there is no real cure for this. [Same people will happily
download any temproray test version from a FTP server, though.]

> > Current U-Boot is 1.3.0-rc4. Please wake up.
> 
> Well... maybe it's better to remove all references to the old
> releases at sourceforge and point them to ftp://ftp.denx.de/pub/u-boot/

Can you please teach me how to do that?

> instead. Btw. 1.3.0-rc4 isn't there as well. :-P

Indeed. But there is a "snapshot" link on the gitweb page...

And 1.3.0 will be out in less than 2 hours from now :-)

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
I am an atheist, thank God!
