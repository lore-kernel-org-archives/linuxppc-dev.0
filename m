Date: Thu, 22 Apr 1999 08:46:23 +0200 (CEST)
From: Alexander Larsson <alex@signum.se>
To: Dan Malek <dmalek@jlc.net>
cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Embedded 8xx 2.2.5 kernel tarball
In-Reply-To: <371E0DB4.4D0EB787@jlc.net>
Message-ID: <Pine.LNX.4.04.9904220844570.30192-100000@tammy.signum.se>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




On Wed, 21 Apr 1999, Dan Malek wrote:

> Alexander Larsson wrote:
> 
> > I just merged my local changes with the 2.2.5-embedded sources.
> > I get an error when starting init. (Booting from nfs.)
> >
> > It just says:
> > Freeing unused kernel memory: 32k init
> > put_dirty_page: page already exists
> 
> Ummm.....it would help if I knew a little more about what you are using.
> Like, what kind of board and the kernel configuration?

 I'm gonna look into it myself now, i just wondered if it was something
you've seen before and knew how to fix. It worked in 2.2p7.

> I would see a similar problem when I would configure IDE and not
> configure PCI.  This is because the IDE probes (and other I/O in/out
> operations) map to real memory locations and tend to write on top of
> kernel data structures.  This is my only guess without more information.

 I've turned of both IDE and PCI (i hope, better check).

 / Alex



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
