To: Daris A Nevil <dnevil@snmc.com>
Cc: Alan Wang <wung_y@sina.com>,
	Linuxppc-EmbeddedMaillist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem when read internal memory 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 11 Apr 2001 12:06:54 CDT."
             <3AD48F2E.2C713B89@snmc.com>
Date: Wed, 11 Apr 2001 21:15:17 +0200
Message-Id: <20010411191522.8F36D28417@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3AD48F2E.2C713B89@snmc.com> Daris A Nevil wrote:
>
> register to this same value before booting the Linux kernel.  Your boot
> code should also setup an MMU entry for the IMMR's address by writing to
> the MD_EPN register (MMU Data Effective Page Number Reg) of the PPC.

What makwes you think this is necessary?

> For an example of how this is done you can refer to the boot code for
> the QS850 (MPC850-based board).  The source is located at
> ftp://qslinux.org.  Once you uncompress the tarball you can go to

We  have  PPCBoot   (see   the   CVS   server   at   SourceForge   or
ftp://ftp.denx.de/pub/ppcboot)  booting  on  many,  many  MPC8xx (and
MPC82xx and IBM 40x) systems, but this has never been needed  to  get
Linux  running  (not with any kernel from the 2.2.13, 2.2.14 or 2.4.x
series).


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A student of  probability  soon  realizes  that  by  its  nature  the
billion-to-one  chance  crops  up nine times out of ten, and that the
greatest odds boil down to a double-sided statement: it will  happen,
or it will not.         - Terry Pratchett, _The Dark Side of the Sun_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
