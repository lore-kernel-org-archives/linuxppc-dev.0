Message-ID: <388F18F5.BDE5D395@netx4.com>
Date: Wed, 26 Jan 2000 10:55:33 -0500
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Brendan.Simon@ctam.com.au
CC: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: linuxppc-embedded: main kernel tree
References: <388F3D65.3B420FED@ctam.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brendan John Simon wrote:


> How seperate is the Linux/PPC kernel tree to the main kernel tree ?

It isn't supposed to be, but.....


> I download linux-2.2.14 and there is only support for MBX


....I have never merged the later 8xx updates from the 2.3.xx
tree into 2.2.xx.  The amount of change is a concern for a "stable"
tree, and the couple of occasions I had the time to do this the
tree was locked for update with Linus.  It is on my "to do" list.


> Can support for all the embedded ports be put into the main kernel
> source tree.

The "main" tree is really the 2.3.xx tree right now, and all of
the 8xx support is there.  For some reason, the BitKeeper 2.3.41
version doesn't build.  I fixed a couple of problems, but now I
am wondering if it will build for any PMac platform.......


> That way we can all use the latest stable kernel without having to wait
> for you (or someone else) to create a package on the ftp server.


The only reason I put things on the server was for people that
couldn't get access to a source tree for some reason.  I don't
like to do that, but people got used to it so I continued.  I
may continue to do so only for a 2.2.xx version.


> also reduces the re-porting of board support packages.

We don't have board support packages.......It just reminds me
of horrible hacks people make so they don't have to provide
source code.  With complete source code available, we have
to find a better way (and use better terminology).


> How often is the Linux/PPC kernel for workstations (PowerMacs, etc)
> committed to the main kernel tree ?

Every day?  I have the same complaint most people have expressed
lately.  I work in the BitKeeper tree, which is supposed to be
the official PPC tree and one step away from kernel.org.  I can't
build it for any of my systems.  I have to go looking for something
from Paul or Ben or someone else to get something to work......

With 2.4.xx soon to happen, we should all be working from the
latest 2.3.xx tree from kernel.org.  If it doesn't work (which
is the case now at least for me), it must be quickly corrected.

I copied linuxppc-dev on this message....so what's the deal with
all PPC sources?  When (and from where) will I be able to download
a kernel tree that I can build for anything?

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
