Date: Sun, 30 Jul 2000 06:54:48 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Steffen Haeuser <SteffenH@hyperion-software.de>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: LinuxPPC X Server
In-Reply-To: <yam8246.90.146624920@mail.lf-online.de>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000730062620.1508D-100000@ofey.inetnebr.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 30 Jul 2000, Steffen Haeuser wrote:

> If I use VidModeExtension at first modes which are entered in XF86Config
> are entered as 640x481 (but this is of course a minor problem and can be
> workarounded). The big problem is that the Screen is totally messed up, looks
> to me as if the Bytes_Per_Line are not correct. With 1024x768 it works
> correct, but with no other resolutions (and 1024x768 is too slow for the
> software renderer of the game, I need 640x480). The Hardware is a
> "Blue/White" G3 Mac 1st Revision with (naturally) ATI Rage Graphics
> Hardware. I am using the ATI Rage Driver.

As I said, it works on matrox and control, your problem is specific to ati
support on XF4 (I presume).  Use XF68_FBDev or go bug Ani Joshi or have a
look at the source yourself.  You may be busy at doing your stuff, but
someone with the hardware and interest like you needs to look at this kind
of things.  I hardly think this is a major bug which should hold up a
release of an user app.

> >> - A likely timeframe for first 3D Drivers
> >>   to be released, which optimally should
> >>   not be more than 3 months from now
>
> >Again, what is not working for you?  What have you tried to get them
> >working for you and how did it fair?
>
> I cannot try getting something to work what does not exist. And appearently
> there are no GLX- or DRI-Drivers for ATI Rage (or any other hardware) yet.
> I am talking about Hardware Accelerated Mesa3D here...

Ok, you should say so (3D support for older video cards like ATI Rage) in
your previous message then.  As you may know, DRI drivers already exist
for mga, r128, tdfx, i810 in source form.


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
