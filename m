Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id B5F9BDE12C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Sep 2008 01:58:45 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: direct access to Flash from userland
Date: Fri, 5 Sep 2008 17:50:12 +0200
References: <0B45E93C5FF65740AEAE690BF3848B7AD38369@rennsmail04.eu.thmulti.com>
In-Reply-To: <0B45E93C5FF65740AEAE690BF3848B7AD38369@rennsmail04.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200809051750.13421.arnd@arndb.de>
Cc: Dave Littell <littelld@verizon.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 04 September 2008, Fillod Stephane wrote:
> >Is there a way for a userland application to issue non-CFI commands
> >directly to a Flash device? =A0(This is a 2.6.18-based kernel on a AMCC
> >PPC440EPx platform.)
>=20
> I don't know whether there's specific ioctl for such purpose.
> Have you tried to read the mtd source? You may also hack the mtd
> layer to add your command. Definitely a question for=20
> http://www.linux-mtd.infradead.org/mail.html
>=20

There is no ioctl command for sending arbitrary requests to the
flash, but it sounds like something that should be implemented
in the kernel, in mtdchar, depending on what the command does.

What are you actually trying to do with those commands?

	Arnd <><
