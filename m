Date: Tue, 2 Nov 1999 14:07:22 -0600 (CST)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Florent <flobo@iname.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Newworld OF boot
In-Reply-To: <381f2fd9382470a6@villosa.wanadoo.fr> (added by villosa.wanadoo.fr)
Message-ID: <Pine.LNX.3.96LJ1.1b7.991102140030.2751A-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 2 Nov 1999, Florent wrote:

[...]
> In the past (before BootX), I used to boot LinuxPPC on a floppy where there
> was an XCoff kernel (boot fd:\\vmlinux.coff). How can I compile an XCoff
> kernel to try it ?

"make vmlinux.coff" used to produce XCoff binary.  It looks like
"make zImage" should produce XCoff image according to
arch/ppc/coffboot/Makefile.


Good luck!

Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
