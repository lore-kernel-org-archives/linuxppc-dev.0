Message-ID: <394DE11A.6196C0BC@student.ethz.ch>
Date: Mon, 19 Jun 2000 11:00:10 +0200
From: Michel Dänzer <daenzerm@student.ethz.ch>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: 3D accel on PPC
References: <394DD484.6036B7DA@student.ethz.ch> <19040101091231.12085@mailhost.mipsys.com>
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> On Mon, Jun 19, 2000, Michel Dänzer <daenzerm@student.ethz.ch> wrote:
>
> >
> >XF 4.0.1 will include DRI support for Rage128. However, it needs agpgart to
> >work, so no luck on PPC yet :(
>
> Their implementation is not able to work at all without an AGP GART ?
> That's brain-dead !

Hmm... looking at recent changes in the DRI ati-4-0-1 branch, I spotted the
following:

- Added minimal PCI support (PIO only with no VBs)
  - Autodetect PCI cards -- selets CCE PIO mode and disables VBs
  - Kernel module will now build without AGP support (for PCI cards only)

Is this good news? If yes, let's hope it'll be in 4.0.1 ...


> what about all the 3D PCI cards out there ? And all the machines that simply
> don't have a working AGP ? AGP should be an optimisation, not a requirement!

Of course, but we are living in an x86 centric world *sigh*


> I have all the details (I think) to implement support for the Uni-N GART
> in the new Core99 macs, I'll give this a try one of these days.

Cool! What about the DRM module, any idea if it works?


Michel


--
Pauli's exclusive, Heisenberg's uncertain, and Schroedinger just waves.
______________________________________________________________________________
Earthling Michel Dänzer (MrCooper)  \  CS student and free software enthusiast
Debian GNU/Linux (powerpc,i386) user \   member of XFree86, Team *AMIGA*, AUGS

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
