Date: Sat, 14 Aug 1999 11:36:43 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: Paul.Mackerras@cs.anu.edu.au, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <d3so5mdyta.fsf@lxp03.cern.ch>
Message-ID: <Pine.LNX.3.96.990814113514.29221B-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 14 Aug 1999, Jes Sorensen wrote:

> David> #define eieio() __asm__ volatile("li 0,0: cmpwi 0,0; bne+ 0f;
> David> eieio; 0:" : : : "0")
> 
> Defininf a C function with the name of a PPC specific assembler
> function is pretty stupid. To the best of my knowledge wmb() is the
> generic name for the thing you are looking for.

Keep in mind, I'm talking about MkLinux, _not_ LinuxPPC.  wmb() is a
linux-specific term, as far as I know.  The above is in mach.


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
