To: Jaap-Jan Boor <jjboor@aimsys.nl>
Cc: linuxppc-embedded@lists.linuxppc.org,
	JACK HWAN <jhfami@yahoo.co.kr>
Subject: Re: Booting time 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 10 Feb 2004 08:48:54 +0100."
             <93314AB1-5B9D-11D8-B8DD-000A95B15278@aimsys.nl>
Date: Tue, 10 Feb 2004 20:52:42 +0100
Message-Id: <20040210195247.432DDC1215@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Jaap-Jan,

in message <93314AB1-5B9D-11D8-B8DD-000A95B15278@aimsys.nl> you wrote:
>
> > For a "standard" system with 50 MHz CPU and 50 MHz bus  clock  I  can
> > demonstrate  that  it takes not more than 3...4 seconds from power on
> > until the first application process is running.
>
> What kind of setup is that? A very small ramdisk or flash disk?

This is with a standard setup; root filesystem size is in  the  range
of  5...10 MB. It works with a ramdisk (if not compressed), or with a
MTD based (non-compressing) filesystem. The  second  option  is  more
efficient regarding memory footprint in RAM.

A MTD mounted (read-only) ext2 filesystem in flash is pretty fast.

> Does the (u-) boot loader do extensive ram tests?

Just the basic tests which are also used to auto-size the RAM.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only way to learn a new programming language is by  writing  pro-
grams in it.                                        - Brian Kernighan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
