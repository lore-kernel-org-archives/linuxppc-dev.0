Date: Sat, 20 Nov 1999 01:18:33 -0500
From: Eric Dorland <dorland@lords.com>
To: "David A. Gatwood" <dgatwood@deepspace.mklinux.org>
Cc: Hollis R Blanchard <hollis+@andrew.cmu.edu>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Floppy problems
Message-ID: <19991120011833.B515@HSE-MTL-ppp4368.qc.sympatico.ca>
References: <19991120005342.A515@HSE-MTL-ppp4368.qc.sympatico.ca> <Pine.LNX.3.96.991119221517.13279D-100000@deepspace.mklinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.3.96.991119221517.13279D-100000@deepspace.mklinux.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, Nov 19, 1999 at 10:17:00PM -0800, David A. Gatwood wrote:
> On Sat, 20 Nov 1999, Eric Dorland wrote:
> 
> > I've tried a bunch of different floppies (at least 5), all give the exactly
> > same error. The drive works flawlessly in the MacOS. I don't really have
> > MkLinux installed to test it. Something I forgot to mention. When I try to
> > to do dd, it gives the error and hangs the terminal. I can switch to another
> > virt. console, but the dd process refuses to die. Is there something odd
> > about the G3 floppy drive? Does anyone have this problem?
> 
> It does sound like a driver bug.  And no, the G3 machines should be using
> the same (Mitsubishi or Panasonic) mechanisms used in all the other
> PowerMacs.  It's remotely possible they used the Sony mechanism, but I
> don't think they've done that since the Quadras, so....

It is very weird. Again, other G3 users, does your floppy drive work?

> > BTW, is there any utility in the MacOS to write raw disk images? DiskCopy
> > will mount them, but doesn't seem to want to write them to a floppy. (Its a
> > Debian i386 bootdisk).
> 
> DiskCopy should be able to write them, too.

It can't, it copes out with a -54 error. Looking it up its a permError
(trying to write a locked file) which doesn't make much sense.

Eric Dorland
dorland@lords.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
