Date: Thu, 18 Nov 1999 21:11:29 +0100 (CET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Nelson Abramson <pogtal@erols.com>
cc: LinuxPPC-User List <linuxppc-user@lists.linuxppc.org>,
        linuxppc-developer <linuxppc-dev@lists.linuxppc.org>
Subject: Re: gEDA
In-Reply-To: <3834522D.16BE27ED@erols.com>
Message-ID: <Pine.LNX.4.05.9911182110520.3289-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Nov 1999, Nelson Abramson wrote:
> Anyone good at making rpms-
>     The gEDA package is a really good software.  Totally GPL and it
> compiled from the source on my machine w/o any alteration of the
> gEDA source (it required deleting the gtk+, guile, and glib rpms and
> compiling the newest ones from source though..).  Having an rpm of this
> in the science directory on linuxppc would be nice :)
> Hey, debian already has one!! :) (for ix86 that is...)

Wrong... Debian GNU/Linux for PowerPC also has it:

| [21:10:19]~# dpkg -s geda
| Package: geda
| Status: install ok installed
| Priority: optional
| Section: electronics
| Installed-Size: 11
| Maintainer: Hamish Moffatt <hamish@debian.org>
| Version: 19990919
| Depends: geda-gschem
| Suggests: geda-gnetlist, geda-utils, geda-gsymcheck
| Description: GNU EDA -- Electronics design software
|  GNU EDA, an electronics design package, including
|  gschem, a schematic editor. This is alpha software!
| 
| [21:10:41]~# uname -a
| Linux callisto 2.3.18 #71 Mon Oct 25 19:35:36 CEST 1999 ppc unknown
| [21:10:46]~# 

Gr{oetje,eeting}s,
--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
