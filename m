Date: Wed, 16 Dec 1998 10:13:15 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: linux-scsi@vger.rutgers.edu
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Diamond Fireport 40 (Sym875) 
In-Reply-To: <Pine.LNX.4.03.9811252309520.23541-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.03.9812161008510.11635-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 25 Nov 1998, Geert Uytterhoeven wrote:
> On Mon, 23 Nov 1998, I wrote:
> > I'm considering to buy a Diamond Fireport 40 (SYM53C875 based) UW-SCSI host
> > adapter for my CHRP box (Linux/PPC). Are there known problems with this board
> > on non-Intel architectures?
> >
> > Should I go for a SYM U2W-SCSI board instead? I have a Quantum Viking II U2W,
> > which is currently connected to the (slow) onboard MESH Fast SCSI.
> 
> I borrowed a FirePort 40 from a friend for testing.
> 
> I have the following SCSI devices:
> 
>   - QUANTUM VIKING II 4.5WLS Rev 3506 (U2W, with UW68-to-U50 convertor) 
>   - HP HP35480A Rev T503
>   - QUANTUM FIREBALL_TM3200S Rev 300X (the one with tagged queueing bug ;-(
>   - PLEXTOR CD-ROM PX-12TS Rev 1.02
> 
> Originally these were all connected to the on-board MESH Fast-SCSI controller,
> using a narrow cable, termination on the CD-ROM.
> 
> Since I had no wide cable for testing, I always used the Viking with the
> UW68-to-U50 convertor, even on the '875.

Just bought a Dawicontrol DC-2976UW (Sym875 based), and it works fine with the
ncr53c8xx driver under Linux/PPC. This time I connected the Viking II using a
wide cable. Now it flies at 17 MB/s. Connected to the MESH, it did 6 MB/s only.
The '875 also causes less interrupt stress: a simple read benchmark with hdparm
generates only 256 interrupts, compared to approx. 3500 with the MESH. 

The only disadvantage is that I don't have an Open Firmware driver for the
'875, so I can't boot from the disk. I have to keep my Fireball on the MESH.
Well, I'll get a cheap second hand disk for booting, so I can move the Fireball
to the '875, too.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
