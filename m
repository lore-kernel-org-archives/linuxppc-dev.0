Message-Id: <9908120516.AA43198@marc.watson.ibm.com>
To: Richard Henderson <rth@cygnus.com>
Cc: Paul.Mackerras@cs.anu.edu.au, Jes.Sorensen@cern.ch,
        Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC 
In-Reply-To: Message from Richard Henderson <rth@cygnus.com>
   of "Wed, 11 Aug 1999 21:40:49 PDT." <19990811214049.A14692@cygnus.com>
Date: Thu, 12 Aug 1999 01:16:14 -0400
From: David Edelsohn <dje@watson.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> Richard Henderson writes:

>> My position is that if you can provide the ordering at essentially
>> zero cost, then it is an advantage to have it since more drivers will
>> work that way.

Richard> But it isn't zero cost.  It's not high cost, but that's not the same thing.

	Is your assumption that you want to provide the infrastructure to
write high-performance device drivers or to write device drivers that
don't require as much expertise and knowledge to produce correct results?
There are conflicting goals in this design providing different benefits to
Linux. 

David


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
