Date: Wed, 17 Apr 2002 00:04:19 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: Michel Lanners <mlan@cpu.lu>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: ATI 7000 and dual-monitor X? (was Re: 9600 maturity?)
In-Reply-To: <E16xb2p-0000Bv-00@piglet.grunz.lu>
Message-ID: <Pine.BSF.4.44.0204170001540.61655-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Apr 2002, Michel Lanners wrote:

> Can somebody please teach XFree to leave those VGA ports alone on PPC?
> Are they of _any_ use on any PPC machine?

Yes, they are of use on Macs (I assume you meant pmacs instead of PPC,
cause LOTS of ppc's use vga).  How else would u program a VGA card on a
mac without use of the VGA ports?  The solution is for XFree86 to bang the
proper IO space when there are multiple busses, this is being worked on.


ani


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
