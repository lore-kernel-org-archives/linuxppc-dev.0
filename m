To: =?iso-8859-1?q?Michel_D=E4nzer?= <daenzer@debian.org>
Cc: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>
Subject: Re: PREEMPT on PPC
References: <Pine.LNX.4.44.0403261442210.3900-100000@opal.biophys.uni-duesseldorf.de>
	<1080329240.17435.293.camel@thor.asgaard.local>
From: Mathieu Segaud <matt@minas-morgul.org>
Date: Sat, 27 Mar 2004 10:14:26 +0100
In-Reply-To: <1080329240.17435.293.camel@thor.asgaard.local> (Michel
 =?iso-8859-1?q?D=E4nzer's?= message of "Fri, 26 Mar 2004 20:27:20 +0100")
Message-ID: <871xneabyl.fsf@minas-morgul.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Dänzer <daenzer@debian.org> writes:

> On Fri, 2004-03-26 at 18:48, Michael Schmitz wrote:
>>
>> Works fine here on 2.6.5-rc2-ben0 . Including disk suspend.
>
> Have you hit swap with it? The problems with preempt usually only
> started at that point here.

here I hit swap on my iBook2.2, and GCC gives ICE segfault every 5 minutes in a
kernel compilation. And X does not last longer than one hour.
Seems to be some other races.

--
Mathieu Segaud

"This, btw, is not something I would suggest you do in your living room.
 Getting a penguin to pee on demand is _messy_. We're talking yellow spots
 on the walls, on the ceiling, yea verily even behind the fridge. However.
 I would also advice against doing this outside - it may be a lot easier to
 clean up, but you're likely to get reported and arrested for public
 lewdness Never mind that you had a perfectly good explanation for it all."

 	- Linus Torvalds on sprinkling holy penguin pee

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
