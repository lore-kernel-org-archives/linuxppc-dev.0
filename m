Date: Fri, 26 Sep 2003 14:24:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Joakim Tjernlund <joakim.tjernlund@lumentis.se>
Cc: Dan Malek <dan@embeddededge.com>,
	Jean-Denis Boyer <jdboyer@m5t.com>,
	Steffen Rumler <Steffen.Rumler@siemens.com>,
	linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problem of concurrency in arch/ppc/8260_io/uart.c
Message-ID: <20030926212410.GB8927@ip68-0-152-218.tc.ph.cox.net>
References: <IGEFJKJNHJDCBKALBJLLEEGCFPAA.joakim.tjernlund@lumentis.se> <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <IGEFJKJNHJDCBKALBJLLGEGDFPAA.joakim.tjernlund@lumentis.se>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Sep 17, 2003 at 06:33:06PM +0200, Joakim Tjernlund wrote:
>
> > > Whatever the boot rom initializes.
> >
> > OK, then I will assume TX buffer length of 1, until serial_console_setup has run and
> > initialize it to 4.
> >
> >  Jocke
>
> Here we go again. This patch adds the above. I am unable to break it, please try to :)

KGDB still works for me.  Dan, any final thoughts / comments /
objections?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
