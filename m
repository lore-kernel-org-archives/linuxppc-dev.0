Date: Thu, 6 May 1999 16:48:21 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
To: Mike Ladwig <mike@twinpeaks.prc.com>
cc: linuxppc-dev@lists.linuxppc.org, tmrini@ntplx.net
Subject: Re: atyfb and 8500+ATI RagePro
In-Reply-To: <37318C55.FD33BC88@twinpeaks.prc.com>
Message-ID: <Pine.LNX.4.10.9905061647180.3082-100000@mercator.cs.kuleuven.ac.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 6 May 1999, Mike Ladwig wrote:
> I wrote:
> > > Recently, I came across a post my Hugy Caley about a "hacked" atyfb
> > > driver from Abe White.  I thought I'd give it a try.  Using the
> > > parameter line, "video=atyfb:vmode:19,cmode:16", I actually get a
> > > somewhat reasonable display
> 
> Since writing this, I have found the single key line to the Abe White
> patch
> that helps me.  I noticed that in the 104 version of atyfb that
> RagePro LT stuff similar to the hack was added in, so I thought I'd
> focus on
> what wasn't added.
> 
> If I add an immediate 'return' to aty_set_pll_ct, my
> system will boot with BootX parameter "video=atyfb:vmode:19,cmode:16". 

Hence the problem lies within the programming of the pixel and memory clocks.

> I believe
> the atyfb driver is at least somewhat working here, because I can run
> Xconfigurator and get an FB_Dev X server up, so long as I pick a display
> mode close to
> vmode:19,cmode:16.  X doesn't work outside of Xconfigurator, but I hope

Indeed, then you cannot change the pixel clock so you must choose modes that
are close enough.

Greetings,

						Geert

--
Geert Uytterhoeven                     Geert.Uytterhoeven@cs.kuleuven.ac.be
Wavelets, Linux/{m68k~Amiga,PPC~CHRP}  http://www.cs.kuleuven.ac.be/~geert/
Department of Computer Science -- Katholieke Universiteit Leuven -- Belgium


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
