Date: Sat, 6 Oct 2001 18:37:24 -0700 (PDT)
From: Ani Joshi <ajoshi@shell.unixbox.com>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: <yellowdog-devel@lists.yellowdoglinux.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: ATI Radeon 32MB PCI, Apple 17 Flat panel on B+W G3
In-Reply-To: <20011006122650.NJWF27994.tomts14-srv.bellnexxia.net@there>
Message-ID: <Pine.BSF.4.32.0110061833480.59459-100000@shell.unixbox.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Kevin,

Ben's kernel tree has a relatively recent version of radeonfb, I will
send out an updated newer version in a couple days.  As for X, you can
build 4.1.0 and apply the patch I have in my dir on ftp.linuxppc.org
(users/ajoshi/radeon) or you can build X cvs which has my fixes applied.
DRI support is still in progress.

Flat panel support in radeonfb will be nice, I will try and send you some
code over for that as I do not have a flat panel display.


ani


On Sat, 6 Oct 2001, Kevin B. Hendricks wrote:

>
> Hi,
>
> I just bought an ATI Radeon 32M PCI video card (with dvi output) so that I
> could connect up a new Apple 17" flat panel display to my old B+W G3.
>
> (dual video cards)
>
> Any chance these are supported under PPC Linux?
>
> What kernels and XFree86 versions support ATI Radeon 32Meg PCI cards?
>
> What about Apple flat panel displays?
>
> Thanks,
>
> Kevin
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
