Date: Thu, 12 Aug 1999 17:11:49 +1000
Message-Id: <199908120711.RAA30446@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: rth@cygnus.com
CC: dje@watson.ibm.com, Jes.Sorensen@cern.ch,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, rth@cygnus.com
In-reply-to: <19990811225231.B14713@cygnus.com> (message from Richard
	Henderson on Wed, 11 Aug 1999 22:52:31 -0700)
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <rth@cygnus.com> <9908120516.AA43198@marc.watson.ibm.com> <19990811225231.B14713@cygnus.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Richard Henderson <rth@cygnus.com> wrote:

> I prefer high-performance drivers. 

Sure, so do I.  But when I can get safety as well, for the cost of one
extra cpu cycle per device access, which can probably be overlapped
with the device access anyway, I think it's a good deal.

On alpha, does wmb() stop a subsequent load from being moved ahead of
a previous store?  Or do you have to use mb() to get that effect?

Paul.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
