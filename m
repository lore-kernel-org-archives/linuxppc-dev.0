Date: Wed, 20 Jan 1999 22:28:13 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: davies@maniac.ultranet.com, Donald Becker <becker@cesdis1.gsfc.nasa.gov>
cc: Linux kernel <linux-kernel@vger.rutgers.edu>,
        Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: de4x5 vs. tulip on PPC
Message-ID: <Pine.LNX.4.03.9901202221410.28223-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



On my machine, de4x5.c works, while tulip.c doesn't.

Machine is a CHRP/PPC box, Ethernet is 21041 based D-Link DE-530CT.

Relevant kernel messages:

| eth0: DC21041 at 0x1080 (PCI bus 0, device 4), h/w address 00:80:c8:5a:f8:5b, 
                                                             ^^^^^^^^^^^^^^^^^
|       and requires IRQ29 (provided by PCI BIOS). 
| de4x5.c:V0.543 1998/12/30 davies@maniac.ultranet.com 
| eth0: media is TP. 

| tulip.c:v0.89H 5/23/98 becker@cesdis.gsfc.nasa.gov 
| eth0: Digital DC21041 Tulip at 0x1080, 21041 mode, 80 00 5a c8 5b f8, IRQ 29. 
                                                     ^^^^^^^^^^^^^^^^^
| eth0: 21041 transmit timed out, status fc680000, CSR12 000001c8, CSR13 ffffef05, CSR14 ffffff3f, resetting... 
| eth0: 21041 transmit timed out, status fc680010, CSR12 000052c8, CSR13 ffffef09, CSR14 fffff7fd, resetting... 
| eth0: 21041 transmit timed out, status fc680010, CSR12 000001c8, CSR13 ffffef05, CSR14 ffffff3f, resetting... 
| eth0: 21041 transmit timed out, status fc680010, CSR12 000052c8, CSR13 ffffef09, CSR14 fffff7fd, resetting... 

So at least the Ethernet HW address is in the wrong endiannes for tulip.c.

Are there people who can use tulip.c on a big endian machine?

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
