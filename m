Date: Tue, 27 Apr 1999 08:06:50 -0400 (EDT)
From: Kevin Hendrickson <hndrcksn@net178019.hcv.com>
To: Dana Spiegel <danas@mit.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: B&W G3 booting, but no X
In-Reply-To: <v04020a03b34a30bcec3e@[18.248.0.159]>
Message-ID: <Pine.LNX.3.96.990427080043.18709A-100000@net178019.hcv.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Apr 1999, Dana Spiegel wrote:

> 
> So I have my new B&W G3 400 booting with linuxppc using the yellowdog
> kernel. The install went flawlessly, and I can boot into linux using bootX
> 1.0.1.
> 
> here's the problem: I got the iMac XF68 framebuffer X server, but I can't
> get it to work properly. I tried the default XF86Config, but it complains
> there are no usable X modes. I also tried the imac XF86Config, which of
> course only has resolutions up to 1024x768. It said it couldn't find any
> usable resolutions either.

Are you able to run Xconfigurator? Does it correctly identify your card
and report the correct amount of VRAM? I had a problem with my ixMicro
card until I realized I had been using the "No video driver" setting in
BootX. Once I unchecked this, I was able to get the correct amount of VRAM
to show up in Xconfigurator and choose a resolution and color depth that
worked. 
 
> I run my monitor at 1600x1200@75Hz in 24bit color (nice video card). Can I
> get X to work properly? I'd like to keep this resolution (but would be
> willing to run in 16bit color if necessary).
> 
> Also, what about compiling XFree86 SVGA server to support the ATI chipset
> natively? Can this be done?

Kevin Hendrickson
*--------+---------+---------+---------+---------+---------+---------+-*
Kevin Hendrickson          "On the internet, no one knows you're a dog."
hndrcksn@net178019.hcv.com   "Why, oh why, didn't I take the BLUE pill?"   
hndrcksn@braincraft.com   _DreaD_    http://net178019.hcv.com/~hndrcksn/ 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
