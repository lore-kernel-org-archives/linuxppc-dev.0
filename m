Date: Thu, 1 Jul 1999 13:26:59 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: "Velasquez, Carlos" <carlos.velasquez@ssmb.com>
cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Re: kernel args for video mode..
In-Reply-To: <BFC0587634C3D111AACB00805FA766FA02C1C5FC@exchny12.ny.smb.com>
Message-ID: <Pine.LNX.4.05.9907011324440.4462-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 1 Jul 1999, Velasquez, Carlos wrote:

> So how do I specify it as kernel arguments? should I say:
> video=tt128mb8 , vmode = XX , cmode =YY  (where XX and YY are the resolution
> and bit depth respectively) or instead of commas, do I use semi-colons or
> colons or what?

video=imsttfb:vmode:XX,cmode:XX where vmode is one of the ones defined in
/usr/src/linux/include/video/macmodes.h, and cmode is 8/16/32.

> Also, do I uncheck the "Don't use Video driver" choice box? What happens if
> I keep it checked ? Finally, how (if possible) do I change video and color
> modes once I am already booted up? Can I do this on the fly?

You uncheck it once you have a video= line to give the kernel.  No Video
Driver over rides any video args you tell it.  You can change things on
the fly in the console with fbset (fbset -h) and in X you can change from
known resolutions with control-keypad- +/- (i think, been a while..)

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
