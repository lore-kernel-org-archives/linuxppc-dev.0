Date: Sat, 14 Aug 1999 18:28:15 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: Paul.Mackerras@cs.anu.edu.au, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <d3d7wq6t56.fsf@lxp03.cern.ch>
Message-ID: <Pine.LNX.3.96.990814182606.29538A-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 14 Aug 1999, Jes Sorensen wrote:

> >>>>> "David" == David A Gatwood <dgatwood@mvista.com> writes:
> 
> David> On 14 Aug 1999, Jes Sorensen wrote: #define eieio() __asm__
> David> volatile("li 0,0: cmpwi 0,0; bne+ 0f; eieio; 0:" : : : "0")
> >>  Defininf a C function with the name of a PPC specific assembler
> >> function is pretty stupid. To the best of my knowledge wmb() is the
> >> generic name for the thing you are looking for.
> 
> David> Keep in mind, I'm talking about MkLinux, _not_ LinuxPPC.  wmb()
> David> is a linux-specific term, as far as I know.  The above is in
> David> mach.
> 
> Urgh
> 
> Ok we were discussing the normal kernel here.

Breakdown in communication again.  What I'm talking about is what
MkLinux's Mach Kernel did to get support for certain machines.  That's why
it was eieio().  It's the _equivalent_ of what LinuxPPC would have to do
to support the same machines, though the details of the names and stuff
would be different.  :-)


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
