Subject: Re: new ATI sleep code freezes
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: mutex@kerneli.org
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030529154143.GC7896@heliosphan>
References: <20030529154143.GC7896@heliosphan>
Content-Type: text/plain; charset=iso-8859-1
Message-Id: <1054496170.25677.28.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Date: 01 Jun 2003 21:36:11 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-05-29 at 17:41, mutex@kerneli.org wrote:
> Hi all,
> This has taken me a while to decide it was a bug and not a freak
> accident. About one to two times a week I have noticed that my powerbook
> will hand during the sleep process. Usually, when the sleep operation
> completes, there is a quick screen power blank. Then about another 1.5
> seconds of the LCD being illuminated, with what looks like some random
> part of video memory being displayed, then finally the machine goes
> to sleep. Occasionally I am seeing a freeze during the step where the
> machine stays on for 1.5 seconds and has not quite been put to sleep. I
> have been unable to diagnose this, as it happens so infrequently, but I
> figured by posting I could hopefully get some more people experiencing
> this as well. my specs:
> 	1ghz tipb, 1gig ram, radeon 9M, 2.4.20-ben8

Pretty much the same configuration here, but I haven't seen this, even
though I've been enjoying uptimes of weeks, usually with at least one
sleep cycle a day.

What's your DRI related setup?


--
Earthling Michel Dänzer   \  Debian (powerpc), XFree86 and DRI developer
Software libre enthusiast  \     http://svcs.affero.net/rm.php?r=daenzer


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
