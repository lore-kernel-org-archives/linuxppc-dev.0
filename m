Date: Tue, 23 Sep 2003 10:28:08 +0200
From: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Subject: RE: Problem of concurrency in arch/ppc/8260_io/uart.c
In-reply-to: <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se>
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Reply-To: joakim.tjernlund@lumentis.se
Message-id: <IGEFJKJNHJDCBKALBJLLEEIBFPAA.joakim.tjernlund@lumentis.se>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> > > Whatever the boot rom initializes.
> >
> > OK, then I will assume TX buffer length of 1, until serial_console_setup has run and
> > initialize it to 4.
> >
> >  Jocke
>
> Here we go again. This patch adds the above. I am unable to break it, please try to :)
> Index: arch/ppc/8xx_io/uart.c

Almost a week has gone and no feedback so far. Anyone?

 Jocke

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
