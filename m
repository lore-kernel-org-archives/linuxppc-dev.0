Date: Tue, 12 Jan 1999 17:25:40 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: satadru pramanik <satadru@umich.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: scsi benchmark.
In-Reply-To: <Pine.LNX.4.05.9901121033490.8499-100000@beer.pub.umich.edu>
Message-ID: <Pine.LNX.4.03.9901121725060.21199-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 12 Jan 1999, satadru pramanik wrote:
> I have a IBM Utrastar on an Adaptec 2940UW, and thought dmesg says it's
> connected at 20Mb/sec, I doubt that is the case.  Is there a way I can
> benchmark the disk performance on my scsi?  something akin to hdparm for
> scsi?

The hdparm read benchmark also works on SCSI disks. FYI, my Quantum Viking II
does 17 MB/s (Sym875).

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
