Date: Thu, 18 Oct 2001 23:21:30 -0500
From: Takashi Oe <toe@unlserve.unl.edu>
To: Andrew P McPherson <apm@MIT.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Compiling BootX?
Message-Id: <20011018232130.55b351bc.toe@unlserve.unl.edu>
In-Reply-To: <Pine.GSO.4.30L.0110172159300.16073-100000@biohazard-cafe.mit.edu>
References: <20011016004536.66a97985.toe@unlserve.unl.edu>
	<Pine.GSO.4.30L.0110172159300.16073-100000@biohazard-cafe.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 17 Oct 2001 22:02:18 -0400 (EDT), Andrew P McPherson wrote:

> Thanks for the suggestion.  Installing the "Wish" extension to change the
> gestalt ID to a PowerMac 6100/60 worked.  I did need  to change the type
> to INIT because otherwise the booter always loaded before Wish.
>
> So now it proceeds to "booting system..." at which point it hangs with no
> visible artifacts on the screen.  While I don't expect it to work without
> kernel changes, the problem here is that I don't have any way of knowing
> whether it booted as far as the kernel or died in the MkLinux booter.
> I'll see if anything comes out the serial port, but I doubt it.
>
> Any ideas on how I might find out?  At least with BootX I could enable
> debugging messages.

Try a gestalt ID for other machine type like 41 for Performa 5200.
It is at least similar to your machine in that its frame buffer
address should be the same as yours.


Takashi Oe

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
