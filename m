Date: Mon, 26 Apr 1999 13:42:37 -0400 (EDT)
From: "P. Barrette" <barretp@mcmail.cis.McMaster.CA>
To: Dana Spiegel <danas@mit.edu>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: B&W G3 booting, but no X
In-Reply-To: <v04020a03b34a30bcec3e@[18.248.0.159]>
Message-ID: <Pine.SOL.3.96.990426134033.26513B-100000@mcmail.cis.McMaster.CA>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Just a thought, can you run X in mono or 16?  I have a similar problem on
an intel netfinity which has an S3 trio 3D with 8 MB sdram, all of which
is not recognized; I run in 16 bit mode with 256k or "vram" when X is
needed.

--------
Paul Barrette
Ph.D. Candidate Classics (Latin Literature)
System Administrator
McMaster University

"Oppositaque ad os manu nescio quid taetrum 
exsibilavit, quod postea Graecum esse affirmabat."
                                      --Petronius

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
> 
> I run my monitor at 1600x1200@75Hz in 24bit color (nice video card). Can I
> get X to work properly? I'd like to keep this resolution (but would be
> willing to run in 16bit color if necessary).
> 
> Also, what about compiling XFree86 SVGA server to support the ATI chipset
> natively? Can this be done?
> 
> thanks,
> 
>                                  Dana Spiegel
> 
>                                  Massachusetts Institute of Technology
>                                  danas@mit.edu
>                                  617/225-6404
> 
> 


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
