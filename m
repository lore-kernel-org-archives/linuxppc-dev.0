To: None Atall <linux_meis@yahoo.com>
Cc: Bruno Coudoin <bcoudoin@anfora.fr>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Raven Cop 8260 Utility 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Feb 2002 05:46:01 PST."
             <20020214134601.48635.qmail@web9706.mail.yahoo.com>
Date: Thu, 14 Feb 2002 15:02:45 +0100
Message-Id: <20020214140250.EE70B109E1@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20020214134601.48635.qmail@web9706.mail.yahoo.com> you wrote:
>  We have the same board. But we haven't been able to
> program ppcboot to flash. For some reason the boot
> sector of the flash can't be writen. So I had to run

You probably have to unlock it first. Some flashes start with sectors
locked, and you have to write an unlock sequence before you can erase
and/or program the sector(s).

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
