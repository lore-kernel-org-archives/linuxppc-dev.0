Message-ID: <20000317080204.16038.qmail@web115.yahoomail.com>
Date: Fri, 17 Mar 2000 00:02:04 -0800 (PST)
From: Michel Danzer <mdaenzer@yahoo.com>
Reply-To: michdaen@iiic.ethz.ch
Subject: Re: USB keyboard lights & kernel 2.3.52 (paul's)
To: Geert Uytterhoeven <geert@linux-m68k.org>,
        jingai <jingai@floatingpenguins.com>
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--- Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, 16 Mar 2000, jingai wrote:
> > Last question:  since my work schedule has been so hectic, I haven't been
> > actually following the threads on XFree86 4.0, so I'm just curious...
> does
> > it currently build on PPC boxes?  And does it support accelerated video
> > with the ATI RagePro, or do is this a good reason for me to go out and
> > actually buy a Rage128 :)
>
> IMHO it's a better reason to help getting the acceleration support for ATI
> RagePro work (yes, this is linuxppc-_dev_ :-).

Shouldn't be a big deal once Kostas and me (and anyone else who wants to
participate :) have settled a reasonable solution for the MMIO_{IN,OUT}
macros.


Michel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
