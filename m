Subject: Re: just compiled a 2.4.19 kernel with smp support...
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: GRAVE Xavier <grave@ipno.in2p3.fr>,
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20021022163130.5160@192.168.4.1>
References: <Pine.OSF.3.91.1021022160554.3474A-100000@ipnosl.in2p3.fr>
	<20021022163130.5160@192.168.4.1>
Content-Type: text/plain; charset=ISO-8859-1
Date: 22 Oct 2002 17:12:29 +0200
Message-Id: <1035299550.1129.1812.camel@tibook>
Mime-Version: 1.0
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Die, 2002-10-22 at 18:31, Benjamin Herrenschmidt wrote:
>
> >> Yah, though XFree CVS should work, and Michel Danzer debs
> >> might too, but that has to be tested with him.
> >I'll try them in a few minutes...
> >> What about radeonfb ? (The kernel framebuffer device). Does
> >> it work with my kernel ?
> >
> >It is in the kernel, but how do you now it work ?
> >
> >I have the two penguin at start.
>
> Ok, if you have the penguins and the text console, then it
> works.

Not necessarily if you're booting with video=ofonly. cat /proc/fb


> I think support for the 9000 have been added to XFree CVS
> recently, though that may not yet be in the DRI one (and
> so Michel snapshots). The XFree CVS is beeing merged
> again into the DRI one now, so this should be fixed soon.

Yep, and in the meantime, you could try telling the radeon driver to
treat it like a 8500 with the ChipID or Chipset directive.


--
Earthling Michel Dänzer (MrCooper)/ Debian GNU/Linux (powerpc) developer
XFree86 and DRI project member   /  CS student, Free Software enthusiast


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
