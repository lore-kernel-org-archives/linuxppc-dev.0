Date: Sun, 4 Jun 2000 10:48:44 -0700
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: [patch] VRAM detection in controlfb
Message-ID: <20000604104844.A13914@quaketop.them.org>
References: <00060311160100.00693@enzo.bigblue.local> <200006040709.JAA00760@piglet.grunz.lu> <v04003a00b5602003688d@[24.66.67.194]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04003a00b5602003688d@[24.66.67.194]>; from nicoya@apia.dhs.org on Sun, Jun 04, 2000 at 10:08:39AM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jun 04, 2000 at 10:08:39AM -0500, Tony Mantler wrote:
> dcbi = data cache block invalidate. If you do this on a dirty cache block,
> data will be lost.
>
> dcbf = data cache block flush. If you do this on a block that isn't in a
> coherent state, data will be lost.
>
> If you have a block that's both dirty and incoherent... well, don't do that. :)

Ew.  I wonder if that's our problem...

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
