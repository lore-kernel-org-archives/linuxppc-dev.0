Date: Sun, 18 Jul 1999 22:53:43 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: Paul.Mackerras@cs.anu.edu.au
cc: stp9@cornell.edu, linuxppc-dev@lists.linuxppc.org
Subject: Re: USB on "Bronze" PowerBook?
In-Reply-To: <199907190236.MAA01193@tango.anu.edu.au>
Message-ID: <Pine.BSF.3.96.990718225201.50420H-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 19 Jul 1999, Paul Mackerras wrote:

> Stephen Travis Pope <stp9@cornell.edu> wrote:
> > Are all Mac USB stacks made for the older interface chips? 
> 
> Not deliberately. :-)

The new PBs have a different OHCI chip (not an OPTi, name escapes me right
now). which neither inkays or the current stack seem to have much/any luck
with.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
