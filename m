To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: A few questions in embedded linux 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Jan 2003 10:15:44 PST."
             <20030117181544.14483.qmail@web11505.mail.yahoo.com>
Date: Fri, 17 Jan 2003 20:22:02 +0100
Message-Id: <20030117192207.F3BF3C608E@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Khai,

in message <20030117181544.14483.qmail@web11505.mail.yahoo.com> you wrote:
>
> We are developing a PCI adapter card based out of the
> PPC440GP using MVL version 2.1 (kernel 2.4.17).
>
> I have several issues as listed below:

Why don't you ask MV then?

> 1. I'd like to reserve a 4M RAM space for DMA
> purposes. What I did was adding
> CONFIG_CMD_LINE="root=60M" since our board has 64MB of
> RAM. How do I know the system really now configure to
> be only 60MB? How then can I get a virtual addr to the

It prints the memory when it boots, something like

Memory: 14200k available (1256k kernel code, 564k data, 52k init, 0k highmem)

> 2. We have a list of files (ie: hhlfiles) required to
> build a RAM DISK that is non networked. What other
> files involved that we need to build a RAM DISK that
> has full network capability( ie: telnet, ftp, ping,
> rlogin, mount, etc...)?

See for example ftp://ftp.denx.de/pub/LinuxPPC/usr/src/SELF/

> 3. When the ethernet driver comes up it does a bootp
> request to find its IP address.... How do we configure
> it such that it picks it up from a file or flash?

Use U-Boot - then you can configure these parameters as  "environment
variables",  which  can  be saved to flash/NVRAM/EEPROM and passed to
the Linux kernel.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Cogito cogito ergo cogito sum - "I think that I  think,  therefore  I
think that I am."          - Ambrose Bierce, "The Devil's Dictionary"

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
