Message-ID: <3BF02921.2C95A660@mvista.com>
Date: Mon, 12 Nov 2001 12:55:13 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: Dan Malek <dan@embeddededge.com>
Cc: Sarnath Kannan <sparc64@rediffmail.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: IDE in Mode 1 (Sandpoint) how ?
References: <20011112124640.6795.qmail@mailweb22.rediffmail.com> <3BEFF427.4000309@embeddededge.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Sarnath Kannan wrote:
>
> > hi all,
> > The Sandpoint user's manual says that WinBond's IDE controller is disabled in mode 1 (s3-down, s4-up), but MontaVista's kernel works in mode 1 with IDE support!
> > How is this possible ?

Because the documentation is misleading...

> The up/down comment is relative to the installation of the board in the chassis.
> Mine are actually the other way around.  I'm not even sure if on/off nomenclature
> would work.

Sarnath, Dan is completely correct, it is relative so you need to first *carefully read* the comments in sandpoint_setup.c that describe the switch setting,
*understand them*, and then *follow them*.   Especially the part where it says:


     " * 'down' is in the direction from the PCI slots towards the PPMC slot;
      * 'up' is in the direction from the PPMC slot towards the PCI slots.
      * Be careful, the way the sandpoint board is installed in XT chasses will
      * make the directions reversed."

> Just keep in mind the troubles are local to your configuration, as this software
> operates fine on a properly configured board.  Just move switches until it works,
> then leave them alone :-).

ditto


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
