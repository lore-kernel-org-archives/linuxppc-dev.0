Message-Id: <199909132033.PAA18441@mailhub.iastate.edu>
Date: Mon, 13 Sep 1999 15:37:36 -0500
Subject: Re: New booter
From: "Kevin Puetz" <puetzk@iastate.edu>
To: Daniel Jacobowitz <drow@false.org>, Andreas Bogk <andreas@andreas.org>
CC: Benjamin Herrenschmidt <bh40@calva.net>, linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


True, but it would be _much_ more convenient if you could just read them 
from a text file. Eventually, of course. Preferably with a syntax as close
as makes sense to quik.conf/lilo.conf

What a week, quik got fixed, AND a new booter for OF-deficient machines to
free them from needing MacOS just to bootstrap Linux!


----------

> On Mon, Sep 13, 1999 at 07:51:46PM +0000, Andreas Bogk wrote:
>>
>> Benjamin Herrenschmidt <bh40@calva.net> writes:
>>
>> > I forgot to mention that the kernel args can be changed by editing the
>> > CMDL resource in the System file with resedit. Don't forget the trailing
>> > 0, it's a C string !
>>
>> What's the point of a boot application that works without MacOS when
>> yu need MacOS to modify the kernel args?
>
>
> You don't.  You can hack them with a hex editor if you prefer.  Are
> there decent tools for dealing with hfs resource forks from linux? Not
> that I know of but there is nothing stopping someone from writing one.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
