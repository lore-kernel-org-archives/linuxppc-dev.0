Date: Sat, 3 Jun 2000 17:09:17 -0700
From: Daniel Jacobowitz <drow@false.org>
To: Michel Lanners <mlan@cpu.lu>, linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
Message-ID: <20000603170917.A11644@quaketop.them.org>
References: <Pine.LNX.3.96LJ1.1b7.1000531195040.22480A-101000@ofey.inetnebr.com> <200006030628.IAA00691@piglet.grunz.lu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200006030628.IAA00691@piglet.grunz.lu>; from mlan@cpu.lu on Sat, Jun 03, 2000 at 08:28:25AM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Jun 03, 2000 at 08:28:25AM +0200, Michel Lanners wrote:
> For those with multiple display adapters, do you think an option
> controlfb:off might make sense? As there is no way to control which card
> gets assigned which framebuffer device, that might help in certain
> situations...

Yes, sounds like a great idea.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
