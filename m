Date: Mon, 7 May 2001 17:09:48 -0600
From: Val Henson <val@nmt.edu>
To: Ken Offer <koffer@arlut.utexas.edu>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Yellow-dog-linux troubles
Message-ID: <20010507170948.O17543@boardwalk>
References: <3AF713D7.3B3500C2@arlut.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3AF713D7.3B3500C2@arlut.utexas.edu>; from koffer@arlut.utexas.edu on Mon, May 07, 2001 at 04:29:59PM -0500
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy,

You should be using the linuxppc_2_4 BK tree (not the ftp.kernel.org tree)

http://www.fsmlabs.com/linuxppcbk.html

Also, if you're using the VSS4, the serial driver doesn't currently
work on it.  I haven't had time to fix it cleanly, so the hack is to
comment out these lines in drivers/char/serial.c:

	if (state->flags & ASYNC_BOOT_AUTOCONF)
		autoconfig(state);

Contact me directly for a kernel snapshot.

-VAL

On Mon, May 07, 2001 at 04:29:59PM -0500, Ken Offer wrote:
>
> Hello all-yall-linuxppc-hackers,
>
> Has anybody out there had any luck getting a Synergy-micro VSS4 board
> (i.e. a cool one-board computer with 4 PPC-G3s on it) to compile the
> latest 2.4.4 and 2.4.2 yellow-dog kernels cleanly?  I'm using gcc
> 2.95.2.  Any gcc above 2.6.3 should compile the kernel cleanly, right?
>
> --
> ______________________________________________________________
> Kenneth Ray Offer, II
> Sr. Systems Analyst
> Applied Research Laboratories/SDD
> University of Texas at Austin
> Office (512) 835-3859   FAX (512) 835-3259
>
> Any opinions expressed above are mine and not necessarily
> those of my employer.
>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
