Date: Mon, 24 Apr 2000 15:07:52 -0400
From: Daniel Jacobowitz <drow@false.org>
To: Michel Lanners <mlan@cpu.lu>
Cc: geert@linux-m68k.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: aty128 and offb and linux-2.3.99pre6
Message-ID: <20000424150752.A25359@drow.res.cmu.edu>
References: <Pine.LNX.4.10.10004192247200.436-100000@cassiopeia.home> <200004240651.IAA00313@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200004240651.IAA00313@piglet.grunz.lu>; from mlan@cpu.lu on Mon, Apr 24, 2000 at 08:51:12AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 24, 2000 at 08:51:12AM +0200, Michel Lanners wrote:
> control is only PCI-based with some abstractions.... It can, however,
> be made to look entirely like a PCI device, if you can avoid poking at
> it afterwards.
>
> I have patches for control anyway (adding it to the PCI device chain,
> precisely); so I might try and implement the changes for control. Or
> are you already working on this, Dan?

I've been too busy with Debian to touch controlfb lately; patches would
be appreciated.

Also, what is the current state of your memory testing?  Or was that
not you?

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
