To: Paul.Mackerras@cs.anu.edu.au
Cc: dgatwood@mvista.com, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
References: <Pine.LNX.3.96.990813143741.27557B-100000@mvista.com> <d3so5mdyta.fsf@lxp03.cern.ch> <199908152316.JAA02196@tango.anu.edu.au>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 16 Aug 1999 09:11:19 +0200
In-Reply-To: Paul Mackerras's message of "Mon, 16 Aug 1999 09:16:47 +1000"
Message-ID: <d3so5kqjxk.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "Paul" == Paul Mackerras <paulus@cs.anu.edu.au> writes:

Paul> Jes Sorensen <Jes.Sorensen@cern.ch> wrote:
>> Defininf a C function with the name of a PPC specific assembler
>> function is pretty stupid. To the best of my knowledge wmb() is the
>> generic name for the thing you are looking for.

Paul> Not exactly, in fact iobarrier() is probably better.

Hmmmm

Probably right, as long as it is made clear that iobarrier() means
memory mapped I/O and not I/O mapped I/O. The name is easy to
misunderstand IMHO.

Other than that I agree, question is whether we need to add more
functions - it seems we are already overly confused.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
