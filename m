Date: Wed, 11 Aug 1999 22:52:31 -0700
From: Richard Henderson <rth@cygnus.com>
To: David Edelsohn <dje@watson.ibm.com>
Cc: Paul.Mackerras@cs.anu.edu.au, Jes.Sorensen@cern.ch,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, Richard Henderson <rth@cygnus.com>
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Message-ID: <19990811225231.B14713@cygnus.com>
References: <rth@cygnus.com> <9908120516.AA43198@marc.watson.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9908120516.AA43198@marc.watson.ibm.com>; from David Edelsohn on Thu, Aug 12, 1999 at 01:16:14AM -0400
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 12, 1999 at 01:16:14AM -0400, David Edelsohn wrote:
> 	Is your assumption that you want to provide the infrastructure to
> write high-performance device drivers or to write device drivers that
> don't require as much expertise and knowledge to produce correct results?

I prefer high-performance drivers. 

There are enough other things (virt_to_bus, ioremap, et al) that are
non-optional that driver writers must learn about for non-peecee
driver programming that proper use of mb/wmb doesn't seem that big a
deal to me.

I guess I personally can afford to be somewhat idealistic in this,
because I only use about 4 drivers -- ncr, aic7xxx, tulip, epic100 --
and the authors of all these drivers have clue.  But the thought of
coddling to folks that can't be bothered to do things Right gives
me hives.



r~

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
