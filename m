Date: Tue, 27 Apr 1999 13:41:42 -0500 (CDT)
From: puetzk6715@uni.edu
Subject: Re: B&W G3 booting, but no X
In-reply-to: <v04020a03b34a30bcec3e@[18.248.0.159]>
To: Dana Spiegel <danas@mit.EDU>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.PMDF.3.96.990427133916.540145960C-100000@uni.edu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 26 Apr 1999, Dana Spiegel wrote:

> So I have my new B&W G3 400 booting with linuxppc using the yellowdog
> kernel. The install went flawlessly, and I can boot into linux using bootX
> 1.0.1.
> 
> here's the problem: I got the iMac XF68 framebuffer X server, but I can't
> get it to work properly. I tried the default XF86Config, but it complains
> there are no usable X modes. I also tried the imac XF86Config, which of
> course only has resolutions up to 1024x768. It said it couldn't find any
> usable resolutions either.

I just figured this out with my friend. You need to edit the end of
/etc/XF86Config. Uncomment the "Screen" section that has mode "default"
and comment (# sign) all the others. Now you should get the same mode you
had im MacOS before BootXing

> I run my monitor at 1600x1200@75Hz in 24bit color (nice video card). Can I
> get X to work properly? I'd like to keep this resolution (but would be
> willing to run in 16bit color if necessary).
> 
> Also, what about compiling XFree86 SVGA server to support the ATI chipset
> natively? Can this be done?

No - thie is not the ATI mach64 (which is supported) but the ATI 128 (for
which no drivers exist yet). So you're stuck with slow X (well, not _too_
slow, as it's a fast machine) for a while.

> thanks,
> 
>                                  Dana Spiegel
> 
>                                  Massachusetts Institute of Technology
>                                  danas@mit.edu
>                                  617/225-6404
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
