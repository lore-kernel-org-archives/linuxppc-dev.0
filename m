Date: Mon, 7 Dec 1998 11:54:07 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: "Timothy A. Seufert" <tas@mindspring.com>
cc: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org,
        paulus@cs.anu.edu.au, daveray@WellsFargo.COM
Subject: Re: Partial fix for 2400 16-bit video problem
In-Reply-To: <v04011702b2914dc3594d@[209.86.156.28]>
Message-ID: <Pine.LNX.4.03.9812071153160.31794-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 7 Dec 1998, Timothy A. Seufert wrote:
> Here is the diff relative to the version of chipsfb.c in the latest vger
> kernel that I synced with:
> 
> ----------cut here-----------
> 360a361
> > 			write_xr(0x82, 0x00);		// disable palettes
> 381a383
> > 			write_xr(0x82, 0x08);		// Graphics gamma
> >enable
> ----------cut here-----------
> 
> If your chipsfb.c is different from mine, here is the context:  The first
> line should be inserted after the line containing "write_xr(0x81, 0x14)"
> and the second line should be inserted after the line containing
> "write_xr(0x81, 0x12)".

Please use `diff -u' next time, so you don't have to tell us about the context
yourself.

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
