Date: Mon, 30 Aug 1999 18:23:48 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Takashi Oe <toe@unlserve.unl.edu>
cc: Kevin Puetz <puetzk@iastate.edu>,
        Ira K Weiny <iweiny@falcon.csc.calpoly.edu>, lambert@jeol.com,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: Communicator Crashes X II
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.990830105621.10779A-100000@selq119.unl.edu>
Message-ID: <Pine.LNX.4.10.9908301823010.27650-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 30 Aug 1999, Takashi Oe wrote:
> On Mon, 30 Aug 1999, Kevin Puetz wrote:
> > A serial port buffer issue is behind the 'FB. overflow ####' crash, also 
> > often exposed during VT changes while PPP is running.
> 
> I think this crash will occur less often, once serial DMA support is
> present.  I've just started writing the necessary DMA code, and I hope to
> get something working within a few weeks for the receiving side.
> 
> > This could be related. Or it might not. I really don't know the subsystem
> > well enough to say.
> 
> I don't really know either, but kernel may be spending too much time in
> the interrupt handling section of the serial driver.

Perhaps the kernel spends too much time in the interrupt handling section of
the IDE driver? We saw similar things on m68k.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
