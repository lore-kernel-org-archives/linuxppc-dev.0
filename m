Date: Thu, 12 Aug 1999 15:27:25 +1000
Message-Id: <199908120527.PAA30218@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: dje@watson.ibm.com
CC: rth@cygnus.com, Jes.Sorensen@cern.ch, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu
In-reply-to: <9908120516.AA43198@marc.watson.ibm.com> (message from David
	Edelsohn on Thu, 12 Aug 1999 01:16:14 -0400)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <9908120516.AA43198@marc.watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


David Edelsohn <dje@watson.ibm.com> wrote:

> 	Is your assumption that you want to provide the infrastructure to
> write high-performance device drivers or to write device drivers that
> don't require as much expertise and knowledge to produce correct results?

Interesting question.

I guess I would be trying both to make it easy to write device drivers
that work, and possible to write very high-performance device drivers.
Particularly since the vast majority of drivers in Linux have been
written for the i386 platform, which doesn't do pesky (;-) things like
reordering reads and writes.

In any case, as far as the question of using readl/writel in
framebuffer code goes, and whether readl/writel should include the
eieio, the measurements I did showed zero performance impact of having
the eieio, in frame-buffer copy code at least.

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
