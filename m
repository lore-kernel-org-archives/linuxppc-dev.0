Date: Wed, 28 Nov 2001 02:25:08 -0500
From: Daniel Jacobowitz <dmj+@andrew.cmu.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: A little fix
Message-ID: <20011128022508.A10703@nevyn.them.org>
References: <0111272236.AA25257@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0111272236.AA25257@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Nov 27, 2001 at 02:36:12PM -0800, Michael Sokolov wrote:
>
> OK, I goofed. It's struct bi_record, not struct bootinfo. I have no idea how I
> could have screwed it up and how could the compiler have missed it. Is it
> another gcc extension to allow struct never_heard_of * as OK? The patch below
> fixes it. It also fixes a remaining bit of the kernel=>platforms rename.

That's not a GCC extension, it's standard C, actually.  It's an opaque
type.


--
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
