Message-Id: <200007301655.RAA17061@hyperion.valhalla.net>
Date: Sun, 30 Jul 2000 17:56:09 +0100
Subject: Re: LinuxPPC X Server
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: SteffenH@hyperion-software.de, Takashi Oe <toe@unlserve.unl.edu>
CC: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Sun, Jul 30, 2000, Steffen Haeuser wrote:
> Am 30-Jul-00 schrieb Takashi Oe:
>
> Hi!
>
>>> Well, if it is not fixed it most likely WILL hold up...
>
>>What's wrong with XF68_FBDev?
>
> Hmmm... I was told to use the ATI thing... did not think this was only a thing
> related to the ATI Driver... but maybe I should try this.
>
>>> Hmmm... I was told that no DRI Drivers would exist even for r128 ... can
> you
>>> point me to a place where I can get this ? And if they exist in Source
> form,
>>> someone has them already in Binary form maybe ?
>
>>www.xfree86.org
>>4.0.1 has them.
>
> Hmmm... I looked on the site, but could only see versions for x86 and Alpha
> there,
> not for PPC... has anybody TRIED this stuff (source) on PPC yet ?
>
> I really do not have the time to try around with untried stuff...
>
> *Has* anybody tried compiling this 4.0.1 version on PPC? Does it work ? Are
> there
> any problems ? Is a Binary Version available anywhere ?

Look back through archive from this list for a post from Ani Joshi - it was
an [ANN].

I saw, also that there are some binaries (don't remember who, sorry) but
these do not include the newest drivers.

On the up side I built it yesterday (with Ani's rsync stuff in place of the
xfree86 directory).  It build without problem - now all I need is time to
test ;-)

At present I'm not able to host the binaries (and not enough experienced
with X to be sure of building the right collection :-)

On the down side it took **all** day to build on my 300M G3.

And yes, there have been reports of people trying it (one yesterday - said
it was quicker in some places & slower in others...)

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
