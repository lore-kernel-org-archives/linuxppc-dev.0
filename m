To: Paul.Mackerras@cs.anu.edu.au
Cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        linux-fbdev@vuser.vu.union.edu, rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
References: <Pine.LNX.4.10.9908091008460.25523-100000@mercator.cs.kuleuven.ac.be> <199908100100.LAA28784@tango.anu.edu.au> <d34si8xfwi.fsf@lxp03.cern.ch> <199908110023.KAA23996@tango.anu.edu.au> <d34si6kcge.fsf@lxp03.cern.ch> <199908112352.JAA25021@tango.anu.edu.au>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 12 Aug 1999 09:38:58 +0200
In-Reply-To: Paul Mackerras's message of "Thu, 12 Aug 1999 09:52:31 +1000"
Message-ID: <d3hfm578j1.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> Jes Sorensen <Jes.Sorensen@cern.ch> wrote:
>> I will have to disagree with you on this one, I consider the PPC
>> implementation to be very broken in this regard.

Paul> "Very broken" - because drivers work and there is no measurable
Paul> performance impact?? !!! ??

Paul> The only possible argument for *not* having the eieio in
Paul> readl/writel is that it hurts performance (actually and
Paul> measurably, not just potentially).

Ok strong wording maybe.

I am just quite displeased when people try to hide the real world from
programmers because most code was written for the x86 by people
without a clue. In the long term I think that sort of approach is
going to bite us since code will not get fixed where it should.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
