Date: Fri, 10 Sep 1999 16:13:22 -0400
From: Daniel Jacobowitz <drow@false.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: controlfb.c bug in VRAM bank2 check if bank1
Message-ID: <19990910161322.A1674@them.org>
References: <37D929E4.205A04B8@chpc.utah.edu> <199909111051.DAA22465@marcus.pants.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199909111051.DAA22465@marcus.pants.nu>; from Brad Boyer on Sat, Sep 11, 1999 at 03:51:25AM -0700
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Sep 11, 1999 at 03:51:25AM -0700, Brad Boyer wrote:
> 
> Lou Langholtz wrote:
> > I've posted before about this problem but to a different audience. As
> > I'm hoping to get this resolved (fixed) though in the main source tree
> > but don't have the chance to test this entirely myself I'm resending
> > here hoping someone else can test things out...
> > 
> > After getting an extra 2MB VRAM for my PowerMac7500 and seeing that only
> > 2MB were still being recognized (despite having just added the 2MB to
> > total to 4MB VRAM), I dug into the controlfb.c code from 2.2.11 and
> > 2.2.12 and made the following changes to get all 4MB VRAM recognized:
> 
> Just remember when making changes like this that the old code works fine
> for some people.  I've had 4M in my 7600 for a long time, and never once
> had a problem with Linux saying I only had 2M.  I don't often have the
> time to do kernel hacking, but I'll try to get a kernel with this patch
> up and running on my computer to see if it breaks things.  I suspect it
> will, since it seems that the old way of detecting is removed.
> 
> Hopefully I can get back to you on this in a few days.

I have a bunch of information on this lying around, and most of my
other kernel problems seem to be resolved now.  I'm in the process of
upgrading to current vger; if it succeeds, I'll try to merge all
pending controlfb stuff tomorrow.

Dan

/--------------------------------\  /--------------------------------\
|       Daniel Jacobowitz        |__|        SCS Class of 2002       |
|   Debian GNU/Linux Developer    __    Carnegie Mellon University   |
|         dan@debian.org         |  |       dmj+@andrew.cmu.edu      |
\--------------------------------/  \--------------------------------/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
