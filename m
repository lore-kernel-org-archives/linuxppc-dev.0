Message-ID: <38FF3543.19894457@adtran.com>
Date: Thu, 20 Apr 2000 11:50:11 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
To: Gabriel Paubert <paubert@iram.es>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: char type is unsigned with PPC gcc?
References: <Pine.HPX.4.10.10004192203100.19933-100000@gra-ux1.iram.es>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi-

 Despite the strongly worded exchanges, this isn't really a big deal.
We all have opinions, which is good.  So long as the compiler lets us
config it the way we think it should be, then I'm happy.

 There are some problems with chars having different signed'ness, such
as many of the GNU tools not compiling correctly on some platforms
though-

Gabriel Paubert wrote:
>
> No, God meant bit 0 to be the MSB ;-) There is no other way around.
> Personnally I always think in big endian with bits numbered from MSB to
> LSB.

 Ummm, endianness has nothing to do with bit ordering from MSB->LSB, it
refers to the order BYTES (or the minimum quanta of assessable data) are
ordered in memory when accessing multi-byte values.  On big-endian
machines the 2-bytes value 0x1234 is stored sequentially as 0x12, 0x34,
whereas little-endian machines store it at 0x34, 0x12.  Notice the bits
in these bytes are not 'mirrored' as you suggest.

 All CPUs I'm aware of (even the PPC) correctly refer to the LSB as
being the rightmost bit, being consistent with the conventions of number
theory and representation, however the PPC is (almost) unique, and
incorrect in labeling the LSB as D31 instead of D0.

> Brain damage is believing that the fact that bit n represents 2 to the
> n has any advantage or mathematical weight.

 Actually not.  The association of data bits Dn as representing 2^n is a
fundamental identity in computer science, electrical engineering, and
mathematics.  A binary numerical value is defined as a polynomial of the
form 2^n-1 + 2^n-2 + n^n-3 + .... 2^0.  The fact that IBM chose to
ignore Mr. Boole's work is an unfortunate historical oversight that we
are stuck with.

> Ok, I have very strong and definitive opinions about these questions, so
> let us agree to disagree. I don't expect to convince you anyway...

 That's OK, I wish you well.  I've got this out of my system now...  ;)

ron

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
