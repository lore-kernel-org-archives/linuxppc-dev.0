Date: Thu, 9 Dec 1999 10:16:31 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Tony Mantler <eek@escape.ca>
cc: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Non-OF Ports (was Re: Need developer to help move JDK ppc port
 forward)
In-Reply-To: <v04003a03b474c17e6e53@[216.81.20.25]>
Message-ID: <Pine.LNX.4.10.9912091012470.32113-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> The interrupt handling in
> <http://www.mklinux.org/cgi-bin/cvsweb/osfmk/src/mach_kernel/ppc/POWERMAC/interr
> upt_performa.c?rev=1.6> looks like what I was hoping I wouldn't have to
> write. Somehow I can't picture apple using a 'check every IRQ source on
> interrupt' method for routing between the 68k and PPC interrupt styles, but
> I guess I wouldn't put it past them. (It also leaves the question of where
> does the NMI go)

You should know Apple better than that. Did you ever hear Mikael Forselius
describe the structure of the Apple interrupt handlers he disassembled? It
was like

- get level 2 interrupt

- get interrupt pending mask, handle first level 2 interrupt

- get level 1 interrupt pending mask, handle first level 1 interrupt

- iterate from 2 until all cows came home. 

Not quite 'every source' but that shouldn't be necessary as you always get
higer level ones immediately anyway.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
