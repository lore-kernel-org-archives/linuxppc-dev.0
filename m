Date: Thu, 10 Dec 1998 20:12:38 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New XF68_FBDev
In-Reply-To: <Pine.LNX.4.03.9812041442140.26444-100000@mercator.cs.kuleuven.ac.be>
Message-ID: <Pine.LNX.4.03.9812102008300.9078-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 4 Dec 1998, Geert Uytterhoeven wrote:
> I made an experimental accelerated XF68_FBDev for Linux/PPC available at

Upgrade time :-)

    http://www.cs.kuleuven.ac.be/~geert/bin/XF68_FBDev-accel-ppc-19981210.gz
    http://www.cs.kuleuven.ac.be/~geert/bin/xc-3.3.3-geert-19981210.diff.gz

Changes:

  - Fillrect and clean up for IMS TwinTurbo (Ryan Nielsen <ran@krazynet.com>)

  - Support for gamma correction on DIRECTCOLOR capable boards (Takashi Oe
    <toe@unlinfo.unl.edu>)

  - XKB maps for the US version of Apple Extended Keyboard II (Takashi Oe, but
    he says it comes from X11R6.3-?.ppc.rpm. I made the changes to the
    Imakefiles). Untested, I don't use XKB nor have ADB keyboards. BTW, these
    maps are in the source patch only.

Oh yeah, binary is linked against glibc-1.99. Source patch is relative to
XFree86 3.3.3.

Enjoy!

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
