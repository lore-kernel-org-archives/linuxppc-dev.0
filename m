Message-ID: <BFC0587634C3D111AACB00805FA766FA02C1C608@exchny12.ny.smb.com>
From: "Velasquez, Carlos" <carlos.velasquez@ssmb.com>
To: "'Tom Rini'" <trini@disparity.net>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: kernel args for video mode..
Date: Fri, 2 Jul 1999 10:45:41 -0400 
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tom (and everyone else),

Thanks for the help, it worked!
Here is a weird thing: It worked well for a few times, then I went back to
the default by checking the "No Video Drivers" option to do some fiddling
around. When I decided to stay with the kernel arguments, the screen boots
up somewhat hazy and light, and the Linux Penguin's colors are all different
shades of grey. Any ideas on what is happening?

I can't find the command fbset at all. Linux reports back that it is an
unknown command. Is it in an  RPM I forgot to install? Where can I download
it from?

Carlos

P.S. I looked at the macmodes.h file and I noticed that the cmode settings
for 8/16/32 bit depth was #DEFINED as 0/1/2 respectively. Should I be using
these values instead of 8, 16, or 32 like so:?

video=imsttfb:video:16,cmode:2

______________________________________________________________________
C.F. Velasquez
Asst. Vice President
Global Database and Technology Division
Salomon Smith Barney, Inc.

> -----Original Message-----
> From:	Tom Rini [SMTP:trini@disparity.net]
> Sent:	Thursday, July 01, 1999 1:27 PM
> To:	Velasquez, Carlos
> Cc:	'linuxppc-dev@lists.linuxppc.org'
> Subject:	Re: kernel args for video mode..
> 
> On Thu, 1 Jul 1999, Velasquez, Carlos wrote:
> 
> > So how do I specify it as kernel arguments? should I say:
> > video=tt128mb8 , vmode = XX , cmode =YY  (where XX and YY are the
> resolution
> > and bit depth respectively) or instead of commas, do I use semi-colons
> or
> > colons or what?
> 
> video=imsttfb:vmode:XX,cmode:XX where vmode is one of the ones defined in
> /usr/src/linux/include/video/macmodes.h, and cmode is 8/16/32.
> 
> > Also, do I uncheck the "Don't use Video driver" choice box? What happens
> if
> > I keep it checked ? Finally, how (if possible) do I change video and
> color
> > modes once I am already booted up? Can I do this on the fly?
> 
> You uncheck it once you have a video= line to give the kernel.  No Video
> Driver over rides any video args you tell it.  You can change things on
> the fly in the console with fbset (fbset -h) and in X you can change from
> known resolutions with control-keypad- +/- (i think, been a while..)
> 
> ---
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
