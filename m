Subject: Re: include/asm-ppc/platforms/
To: linuxppc-dev@lists.linuxppc.org
Message-ID: <OF04BCE99E.8AF57CF2-ON85256B14.00425D94@raleigh.ibm.com >
From: "Ralph Blach" <rcblach@us.ibm.com>
Date: Fri, 30 Nov 2001 08:30:27 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Guys,

I think we are missing the boat, on the include/asm-ppc/platforms.

This does not take into account the embedded world at all.
The correct form of the file should be asm-ppc/core/chip/revsion/board

This is because the IBM Core Connect and the Motorola OCEAN internal
interconnect systems.

These allow for a 405/book E/Mot processor cores to be customized around a
large set of
customized on chip perphials.  It will make the availabily of a large
number different
customized chips with different on chip perphials available.

Thats my justification for core/chip

Now for revsion/intersections   This is a little more difficult.
Book E is now a reality.  The Mot E500 and the IBM 440 have been announced
and are book E processors.
A reality of book E not discussed in the forum here is the expansion op
codes.

This means that different book E processors will have different expansion
op codes.
The Mot book E has an isel instruction and the IBM book 440  has deterine
leftmost zero byte in a string.
(See

http://www-3.ibm.com/chips/techlib/techlib.nsf/products/PowerPC_440GP_Embedded_Processor
Read Writing High performance Assembly functions for the PowerPC 440 Core
and
http://e-www.motorola.com/news_center/press_releases/PR010612C.html

for info on these)

This is my justification for Revision, because different Chip Revision will
Have differnet Expansion
instruction sets.  The following statements have HUGE implecation on
Libraries, because the loader will have to load correct library
according to Chip Revision.

Life is going to be very interesting.

Chip


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
