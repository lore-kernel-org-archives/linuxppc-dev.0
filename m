To: "David A. Gatwood" <dgatwood@mvista.com>
Cc: Paul.Mackerras@cs.anu.edu.au, Geert.Uytterhoeven@cs.kuleuven.ac.be,
        linuxppc-dev@lists.linuxppc.org, linux-fbdev@vuser.vu.union.edu,
        rth@cygnus.com
Subject: Re: [linux-fbdev] Re: readl() and friends and eieio on PPC
References: <Pine.LNX.3.96.990814113514.29221B-100000@mvista.com>
From: Jes Sorensen <Jes.Sorensen@cern.ch>
Date: 14 Aug 1999 21:48:05 +0200
In-Reply-To: "David A. Gatwood"'s message of "Sat, 14 Aug 1999 11:36:43 -0700 (PDT)"
Message-ID: <d3d7wq6t56.fsf@lxp03.cern.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>>>> "David" == David A Gatwood <dgatwood@mvista.com> writes:

David> On 14 Aug 1999, Jes Sorensen wrote: #define eieio() __asm__
David> volatile("li 0,0: cmpwi 0,0; bne+ 0f; eieio; 0:" : : : "0")
>>  Defininf a C function with the name of a PPC specific assembler
>> function is pretty stupid. To the best of my knowledge wmb() is the
>> generic name for the thing you are looking for.

David> Keep in mind, I'm talking about MkLinux, _not_ LinuxPPC.  wmb()
David> is a linux-specific term, as far as I know.  The above is in
David> mach.

Urgh

Ok we were discussing the normal kernel here.

Jes

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
