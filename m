Subject: RE: Anyone using an IBM RISCWatch ICE?
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Wed, 15 Aug 2001 15:44:56 -0400
Message-ID: <FF6CF34C346E724596A2FB5CAAB2C49750C3C3@voyager.ops.infiniswitch.com>
From: "Wright, David" <dwright@infiniswitch.com>
To: <frowand@mvista.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Sigh.  As is all too often the case, it was an example of user error
(mine).  I thought I was setting a hardware breakpoint, but I
misunderstood the RISCWatch interface and was actually trying to set
a software breakpoint.  Once I followed Frank's directions, things
worked great.  (I figured I must be doing SOMETHING wrong; this one
was too severe not to have been seen already if it were a real bug.)

Thanks,

  -- David Wright


> > Hi,
> >
> > I've been attempting to use an IBM RISCWatch ICE on a Walnut system
> > and I'm having problems.  (Spare me any lectures about how I should
> > be using a BDI.  I'm just trying to find out how usable the IBM is,
> > since it's already here.)
> >
> > The specific problem I'm trying to solve is this:  how do I set a
> > breakpoint early in kernel startup, say at start_kernel (just as
> > the MMU is enabled)?  I've tried booting the Walnut so that it
> > comes up into its ROM monitor, then stopping it with the ICE, and
> > setting a hardware breakpoint at the start_kernel virtual address.
>
> The disk in the PC that hosts my RISCWatch crashed yesterday so I'm
> doing this from memory.
>
> I've done that sort of thing quite often.  OpenBios is sitting
> at the menu prompt,
>
>   RW> stop
>   RW> bp set ihw 0xc015a644
>   RW> run
>
> (0xc015a644 is start_kernel)
>
> Then tell OpenBios to boot the kernel.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
