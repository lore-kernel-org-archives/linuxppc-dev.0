Message-Id: <v03020900b3dc26d321fb@[128.32.144.85]>
In-Reply-To: <Pine.BSF.3.96.990718225201.50420H-100000@silver.teardrop.net>
References: <199907190236.MAA01193@tango.anu.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 15 Aug 1999 00:17:18 -0800
To: Tom Rini <trini@disparity.net>, Paul.Mackerras@cs.anu.edu.au
From: Michael Schmitz <schmitzm@uclink4.berkeley.edu>
Subject: Re: USB on "Bronze" PowerBook?
Cc: stp9@cornell.edu, linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> Stephen Travis Pope <stp9@cornell.edu> wrote:
>> > Are all Mac USB stacks made for the older interface chips?
>>
>> Not deliberately. :-)
>
>The new PBs have a different OHCI chip (not an OPTi, name escapes me right
>now). which neither inkays or the current stack seem to have much/any luck
>with.

Apologies if that's been reported before:

I just tried Paul's 2.2.10 on a Lombard machine and the USB mouse works just
fine. The only thing broken in that kernel is ethernet (that's been fixed
in another kernel (2.2.6?)).

	Michael



[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
