Date: Sun, 15 Aug 1999 12:43:12 -0700 (PDT)
From: "David A. Gatwood" <dgatwood@mvista.com>
To: Jes Sorensen <Jes.Sorensen@cern.ch>
cc: Richard Henderson <rth@cygnus.com>, Paul.Mackerras@cs.anu.edu.au,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
In-Reply-To: <d3pv0p72yr.fsf@lxp03.cern.ch>
Message-ID: <Pine.LNX.3.96.990815124117.2698A-100000@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On 15 Aug 1999, Jes Sorensen wrote:

> Richard> Keep in mind that wmb is the name of an Alpha specific
> Richard> assembler insn.  Blame Linus.  ;-)
> 
> Yeah I know that, but it is still a hell of a lot more explaining than
> something that when pronounced sounds like someone having certain
> vital parts of his anatomy cut off.

No, it's pronounced as in "Old Macdownald had a farm, e-i-e-i-o."  :-)
'course it's also short for ensure in-order execution for i/o, probably
about as descriptive as you can get.  ;-)


David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
