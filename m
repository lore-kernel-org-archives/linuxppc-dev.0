Date: Wed, 11 Apr 2001 18:23:52 +0200 (CEST)
From: Florin Boariu <florin@bnv-bamberg.de>
To: David Edelsohn <dje@watson.ibm.com>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: another difference in gcc (2v) ? 
In-Reply-To: <200104111456.KAA15100@makai.watson.ibm.com>
Message-ID: <Pine.LNX.4.21.0104111819040.96-100000@wolverine>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Sorry I jump in like this w/o atually knowing what you're talking about
(I'm not familiar with PPC assembly language, and I didn't follow this
thread), but I just heard the words "exception table" and "incorrect" and
this attracted my attention: I'm now sure whether it's the same problem
(or at least a similar one), but I had some strange segmentation faults
while throwing some C++ exceptions in a project I'm working on. The same
code runs without problems on an i586...

I wasn't able to fix them yet since I was in pressure of time, but one day
I'll have to face them again -- and I'm really not looking forward to
that.

Does this relate? If not, I'm sorry for the rude interruption...

regards,
florin.

On Wed, 11 Apr 2001, David Edelsohn wrote:

>
> 	"subf" and "srawi" only set condition codes if the "Rc" bit is
> set, e.g. "subf." and "srawi."
>
> 	Given the two sequences of code you have sent, I think the problem
> is tht the exception table is being initialized with incorrect labels.
>
> David
>
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
