To: "Tord Andersson" <Tord.Andersson@combitechsystems.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC5200LITE - kernel BUG at page_alloc.c 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 27 Nov 2003 08:52:48 +0100."
             <004B1D7A5257174C9044A1B7BD0E60ED447042@ratatosk.combitechsystems.com>
Date: Thu, 27 Nov 2003 10:54:14 +0100
Message-Id: <20031127095419.9DA4BC5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Tord,

in message <004B1D7A5257174C9044A1B7BD0E60ED447042@ratatosk.combitechsystems.com> you wrote:
>
> I have some troubles when trying to run Linux-2.4.23-pre5 on a an
> MPC5200LITE board (16MB) with U-BOOT 1.0.1). Right after the bogoMIPS
> calculation I get "kernel BUG at page_alloc.c:105", and the system
> reboots (see excerpt at end of mail).

Which board revision / configuration is this? Do  you  have  any  PCI
cards  plugged  in?  Dose the simple memory test ("mtest" command) in
U-Boot work?

> I think the part which goes wrong is when the system tries to check if
> the free pages in memory are OK (__freepages_ok(...)), where the
> (page->mapping) seems to be marked and thus causing a bug.
> Is there some kind of problems related to that all pages resides in the
> zone(0), which seems to be used for DMA?

To me this looks like a memory problem.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Making files is easy under  the  UNIX  operating  system.  Therefore,
users  tend  to  create  numerous  files  using large amounts of file
space. It has been said that the only standard thing about  all  UNIX
systems  is  the  message-of-the-day  telling users to clean up their
files.                            -- System V.2 administrator's guide

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
