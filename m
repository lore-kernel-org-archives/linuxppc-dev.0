Date: Fri, 13 Aug 1999 11:33:51 -0700
From: Richard Henderson <rth@cygnus.com>
To: Paul.Mackerras@cs.anu.edu.au
Cc: Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        Richard Henderson <rth@cygnus.com>
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990813113351.A1810@cygnus.com>
References: <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <19990811003805.A11890@cygnus.com> <199908120017.KAA25043@tango.anu.edu.au> <19990811214049.A14692@cygnus.com> <199908120500.PAA30022@tango.anu.edu.au> <19990811224344.A14713@cygnus.com> <199908120707.RAA30438@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <199908120707.RAA30438@tango.anu.edu.au>; from Paul Mackerras on Thu, Aug 12, 1999 at 05:07:02PM +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 12, 1999 at 05:07:02PM +1000, Paul Mackerras wrote:
> What numbers do you get on alpha if you point it at a framebuffer,
> just for interest?

With some additional numbers for mb vs wmb --

Memory:
none       15    11    11    11    11
1 wmb      10    10    10    10    10
1 mb      140   129    62    59    59
8 wmb     171   157   101   101   101
8 mb      346   270   270   267   267

Millenium2 fb:
none     2599    11    11    11    11
1 wmb      10    10    10    10    10
1 mb      220   130   139   139   139
8 wmb     192   178   192   192   192
8 mb      538   423   423   423   423



r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
