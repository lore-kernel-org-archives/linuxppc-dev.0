Date: Mon, 4 Jan 1999 10:35:41 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Brad Midgley <brad@pht.com>
cc: Paul.Mackerras@cs.anu.edu.au, drow@cs.cmu.edu,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi hangs [drow@cs.cmu.edu: Re: CD-writers] (fwd)
In-Reply-To: <Pine.LNX.3.95.990103224624.29306A-100000@pacific.pht.com>
Message-ID: <Pine.LNX.4.03.9901041034450.5366-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Jan 1999, Brad Midgley wrote:
> i have tried out the current vger kernel and i'd characterize it as "five
> times" as stable. meaning i can copy 125 megabytes from a jaz on the
> external bus to a drive on the internal bus before it crashes--with
> 2.1.130 i could only copy about 25 megabytes before it crashed. the error
> when it crashes is always:
> 
> Kernel panic: Inactive in scsi_request_queueable
> In swapper task - not syncing
> Rebooting in 180 seconds...
> 
> is there anything i could do to help dig up this problem?

Does the patch for drivers/scsi/sd.c fixes this?

I haven't seen this panic anymore since I moved all my devices except my 40
MB boot disk from my MESH to my Sym875.

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
