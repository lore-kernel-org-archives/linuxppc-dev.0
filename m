From: phandel@cise.ufl.edu
Date: Tue, 25 Jul 2000 23:36:48 -0700 (PDT)
To: "William H. Schultz" <whschult@uncc.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Current status on Voodoo3 support?
In-Reply-To: <397E49E9.482279C7@uncc.edu>
Message-ID: <Pine.LNX.4.21.0007252322590.27022-100000@handel3.apple.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 25 Jul 2000, William H. Schultz wrote:

> I was just wondering where I can find information on the status of
> Voodoo3 support.  I noticed with my latest rsync of the 2.4.x kernel
> that DRI support finally compiles--but the voodoo3 module still doesn't
> compile.  Having no experience at all in coding drivers, is there
> anything I can do to help out?

For now, I'd recommend using the 2.4.x driver (tdfxfb.c) in 2.2.
I've put together a patch that should apply cleanly to the 2.2.1{6,7}
kernels, and it is located here:

http://www.cise.ufl.edu/~phandel/linux/patch/

Download and apply the Config.in, Makefile.in, and fbmem.c patches.  If
you have a 2.3.x or 2.4.x tdfxfb.c, you can patch it with the
tdfx_tdfxfb.c.diff patch, or else just grab the already-patched tdfxfb.c
and put it in linux/drivers/video.


Thanks,
Peter

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
