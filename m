Date: Thu, 8 Mar 2001 20:48:00 +0530 (IST)
From: "Srinivas Rao.M" <msrao@vxl.co.in>
To: Gabriel Paubert <paubert@iram.es>
Cc: Embedded Linux list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: speed and space Optimization 
In-Reply-To: <Pine.HPX.4.10.10103081551290.9166-100000@gra-ux1.iram.es>
Message-ID: <Pine.SCO.3.91.1010308204511.15429B-100000@vayudoot>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ok. thanks for the reply Mr. Gabriel. How can i do the bench marking of
these options. Can i get some more information from somewhere on net.
-Srini...


On Thu, 8 Mar 2001, Gabriel Paubert wrote:

>
>
> On Thu, 8 Mar 2001, Srinivas Rao.M wrote:
>
> >
> > hi,
> >
> > Please tell me the various set of compilation flags we should use in
> > order to optimize our code. I want to maintain two seperate versions of
> > my codebase: one with Speed optimized and the other with Space optimized.
> > I have tried enabling the -O. but it is a general optimizer. I want to
> > have two distinct codebases.
>
> Actually, the gcc code generation of PPC lacks in this area. There are
> very few differences between -O2 -Os (first one is the standard for speed
> although you might want to try -O3). -Os is in theory the space
> optimization, but there are very few places in the rs6000/ppc description
> that depend on whether the code should be optimized for space or not.
> There will be some difference, but relatively very small.
>
> 	Regards,
> 	Gabriel.
>

--

Give everything you have today, because anything left over is lost forever.
-Mick Rashid


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
