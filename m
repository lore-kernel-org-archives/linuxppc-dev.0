Date: Sat, 30 Jan 1999 19:43:25 +0100 (MET)
From: Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
Reply-To: Geert Uytterhoeven <geert@linux-m68k.org>
To: Gerd Knorr <kraxel@goldbach.in-berlin.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: iMac: sound?
In-Reply-To: <Pine.LNX.4.05.9901301512490.313-100000@macintoy.masq.in-berlin.de>
Message-ID: <Pine.LNX.4.02.9901301941160.1931-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 30 Jan 1999, Gerd Knorr wrote:
> Is the existing Amiga/PowerMac DMAsound driver supported to work on the
> iMac too?  Simply insmoding it seems not to work, I get these messages in
> the syslog:
> 
> 	AWACS: error, status = 4f00d0
> 	DMA sound driver: Interrupt initialization failed
> 
> In /proc/device-tree/pci/mac-io/davbus/sound I've found:
> 
> $ for a in *; do echo "$a: `cat $a`"; done | tee ~/y
> #input-channels: 
> #output-channels: 
> compatible: burgundy
              ^^^^^^^^
Some time ago I read about a patch to make dmasound work on the burgundy.

<searching>

Posted to this list by Brian Foley <brianfoley@tinet.ie> on Jan 18, 1999.

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
