Date: Sun, 12 Oct 2003 09:17:11 -0700
From: Dale Harris <rodmur@maybe.org>
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Need a Linux PPC kernel which supports the Radeon Mobility 9600
Message-ID: <20031012161711.GY11051@maybe.org>
References: <A6E33C4E-FB6C-11D7-9C03-000393467F1A@arlut.utexas.edu> <1065823660.601.0.camel@gaston> <hhk77bv495.fsf@pygar.theorie.physik.uni-muenchen.de> <1065953260.992.11.camel@gaston> <hhhe2ek5ss.fsf@pygar.theorie.physik.uni-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <hhhe2ek5ss.fsf@pygar.theorie.physik.uni-muenchen.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 12, 2003 at 02:18:43PM +0200, Jens Schmalzing elucidated:
>
> > > 2. The accelerated framebuffer has the right size, but flickers a lot.
>
> > What do you mean by "flickers" ? Can you send me the dmesg output ?
>
> Text is readable and stays in place, but horizontal lines keep
> flashing randomly.  Maybe a monitor detection issue?  I've copied the
> portion of the dmesg output that appeared relevant to me below, please
> let me know if you need everything.
>

I see occasional flickering on my powerbook G4, however 'fbset -match'
usually clears it up.  Or switching between X and console seems to clear
things up, too, or some combination of the two.


Dale


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
