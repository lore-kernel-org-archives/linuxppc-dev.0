Date: Wed, 30 Jun 2004 14:21:13 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: looking for .config file for RPXlite board for 2.6 kernel
In-Reply-To: <Pine.LNX.4.60.0406301326160.10682@localhost.localdomain>
Message-ID: <Pine.LNX.4.60.0406301416270.511@localhost.localdomain>
References: <Pine.LNX.4.60.0406301107130.18110@localhost.localdomain>
 <20040630171458.GA15960@smtp.west.cox.net> <Pine.LNX.4.60.0406301326160.10682@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 30 Jun 2004, Robert P. J. Day wrote:

> and i've selected:
>
> [*] CPM2 SCC/SMC serial port support
> [ ]   Support for console on CPM2 SCC/SMC serial port (NEW)
> [*]   Support for SCC1 serial port
> [ ]   Support for SCC2 serial port (NEW)
> [ ]   Support for SCC3 serial port (NEW)
> [ ]   Support for SCC4 serial port (NEW)
> [*]   Support for SMC1 serial port
> [ ]   Support for SMC2 serial port (NEW)

as i just emailed tom on the side, duh, i took his previous note
stupidly literally, and selected *only* the options he listed.  i
figured out pretty quickly to also select the "Support for console on
CPM2 ..." and, lo and behold, i have kernel boot output on my rpxlite
board.  whew.

so now i get as far as:

RAMDISK: Compressed image found at block 0
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 72k init
Warning: unable to open an initial console.
Kernel panic: Attempted to kill init!


i suspect this is also some silly misconfiguration.  off to track it
down.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
