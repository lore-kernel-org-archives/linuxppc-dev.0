Date: Mon, 7 May 2001 23:58:52 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Yellow-dog-linux troubles
In-Reply-To: <3AF713D7.3B3500C2@arlut.utexas.edu>
Message-ID: <Pine.HPX.4.10.10105072340250.22253-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 May 2001, Ken Offer wrote:

>
> Hello all-yall-linuxppc-hackers,
>
> Has anybody out there had any luck getting a Synergy-micro VSS4 board
> (i.e. a cool one-board computer with 4 PPC-G3s on it) to compile the
> latest 2.4.4 and 2.4.2 yellow-dog kernels cleanly?  I'm using gcc
> 2.95.2.  Any gcc above 2.6.3 should compile the kernel cleanly, right?

No, for PPC 2.95.2 is a strict minimum and I'd rather recommend
Franz Sirl's latest gcc rpms on linuxppc.org. It should be gcc-2.95.3 or
perhaps even 2.95.4 now. Even plain 2.95.2 has fairly easy to trigger bugs
IIRC, older compiler are _much_ worse.

If you like to live dnagerously, you can also download the latest snapshot
from gcc.gnu.org or mirros, but it's sometimes broken enough to prevent
succesful kernel compiles.

Even on Intel 2.7.2 no more works, it had serious bugs in things
apparently as simple as named structure field initialization.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
