Date: Wed, 14 Jul 1999 10:03:28 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Paul.Mackerras@cs.anu.edu.au
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: MESH problems in 2.2.x
In-Reply-To: <199907140509.PAA21467@tango.anu.edu.au>
Message-ID: <Pine.LNX.4.10.9907141002260.10922-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 14 Jul 1999, Paul Mackerras wrote:
> The mesh driver really needs someone to go through and update the
> abort and reset handling to the new way.  The first problem is of
> course to work out exactly how the scsi mid-layer expects host adaptor
> drivers to behave... :-)

I already have a feeling in my little toe who's gonna be the victim...

    push_on_job_queue("fix MESH driver");
    push_on_job_queue("study Linux SCSI subsystem");

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
