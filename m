From: "Jerry Quinn" <jquinn@nortelnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <14245.48042.697347.242992@gargle.gargle.HOWL>
Date: Mon, 2 Aug 1999 11:39:22 -0400 (EDT)
To: Mark Abene <phiber@radicalmedia.com>
Cc: Tom Rini <trini@disparity.net>, linuxppc-dev@lists.linuxppc.org
Subject: Re: platinum video makes me cry...
In-Reply-To: <19990709095001.M822@radicalmedia.com>
References: <Pine.LNX.3.96L.990708142815.2134H-100000@unix47.andrew.cmu.edu> <Pine.BSF.3.96.990709093050.70746F-100000@silver.teardrop.net> <19990709095001.M822@radicalmedia.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> "Mark" == Mark Abene <phiber@radicalmedia.com> writes:

 Mark> I'll attach the "current" platinumfb.c file in its entirety.  Although
 Mark> I've just been informed (and I've verified) that 32bpp doesn't work.  I
 Mark> didn't originally notice because I normally use vmode 20 16, and hadn't
 Mark> checked 32bpp.  So the changes only fix 16bpp (8 still works as
 Mark> before).  I'm looking into why 32bpp doesn't work.  I'm still irritated
 Mark> at how much abstraction was done to make the driver "FBDev-aware".  It
 Mark> was so much simpler in 2.1.24, when ALL recognized modes worked in ALL
 Mark> available bit-depths.  Now I'm playing catch-up since I was previously
 Mark> much too busy to know what was going on with newer kernels and FBDev.

I just tried out your revised platinumfb file.  Kudos - I don't have to use
the OFfb anymore, the video driver works right.  I don't have enough VRAM to
check out the 32bpp mode.

A couple of things I noticed, but don't know if they are directly due to the
driver or a more generic part.  First, at the console, the block cursor is
invisible.  The only way to tell where it is is because it is blinking (also
different) when over a character.  Second, when I switch VT's, I get a resynch 
disturbance.  I'm running an Apple 21" fixed-freq monitor, so there shouldn't
be any attempt to change frequencies.  This resync doesn't happen with 'no
video driver' checked.

I'm running a stock Linus 2.2.10.

As an aside, how do I get XF68_fbdev to work?  It demands a config file.
I tried running Xconfigurator (vague memory since I haven't been following
those discussions), but it only detects 1M of VRAM instead of 2.

And more generally, why does Xpmac do the right thing and XF68_fpdev not?
There seems to be a lot of questions of the form "How do I get X set up
right?".  I guess the question I have is why it's so seamless on the MacOS
side but hairy on the Linux side.  What magic is Apple pulling and how do we
go about wrapping it up so that things work cleanly for Linux too?

Thanks
Jerry

-- 
Jerry Quinn                             Tel: (514) 761-8737
jquinn@nortelnetworks.com               Fax: (514) 761-8505
Speech Recognition Research


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
