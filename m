Date: Sat, 3 Jul 1999 20:34:16 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: "Velasquez, Carlos" <carlos.velasquez@ssmb.com>
cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: kernel args for video mode..
In-Reply-To: <BFC0587634C3D111AACB00805FA766FA02C1C608@exchny12.ny.smb.com>
Message-ID: <Pine.LNX.4.05.9907032033010.29822-100000@ip217.stamford6.ct.pub-ip.psi.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2 Jul 1999, Velasquez, Carlos wrote:

> Here is a weird thing: It worked well for a few times, then I went back to
> the default by checking the "No Video Drivers" option to do some fiddling
> around. When I decided to stay with the kernel arguments, the screen boots
> up somewhat hazy and light, and the Linux Penguin's colors are all different
> shades of grey. Any ideas on what is happening?

No Video Driver and some video= arg?  If the colors aren't right, some
setting for video isn't quite right.  (Some ati cards seem to need a
different mclk).

> I can't find the command fbset at all. Linux reports back that it is an
> unknown command. Is it in an  RPM I forgot to install? Where can I download
> it from?

It might not be installed by default, but it's on the cd (fbset-????)

> P.S. I looked at the macmodes.h file and I noticed that the cmode settings
> for 8/16/32 bit depth was #DEFINED as 0/1/2 respectively. Should I be using
> these values instead of 8, 16, or 32 like so:?

Last I knew either worked...

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
