Date: Fri, 19 Dec 2003 11:10:53 +1300
From: Robin Gilks <robin.gilks@tait.co.nz>
Subject: Re: wdt_mpc8xx documentation
In-reply-to: <1071766780.971.39.camel@shiva.eth.saftware.de>
To: Andreas Oberritter <obi@saftware.de>,
	linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Message-id: <3FE225ED.7070506@tait.co.nz>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
References: <3FE12DCD.10609@tait.co.nz>
 <1071726766.3533.11.camel@shiva.eth.saftware.de>
 <20031218161356.GA28108@stop.crashing.org>
 <1071766780.971.39.camel@shiva.eth.saftware.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Andreas Oberritter wrote:
> On Thu, 2003-12-18 at 17:13, Tom Rini wrote:
>
>>>Tom, would you put this driver into the 2.4 ppc trees if I rediffed
>>>it?
>>
>>Have there been any updates since the last one you sent me? I've
>>actually got it in a tree I'm going to get Marcelo to pull from.
>
> That's great news! The driver has not been not changed since then. The
> last patch I sent to you was for 2.4.23-pre7 I think. Thank you!

My reading of your code interprets the resetting of the watchdog as
being from the real-time clock interrupt. This block does not exist on
newer 8xx CPUs so it looks like I'm going to have to hack the code about
a bit for 859/866 CPUs at least.

Maybe I've missed something - I'd be interested in your feedback (after
the Christmas break!!).

--
Robin Gilks
Senior Design Engineer          Phone: (+64)(3) 357 1569
Tait Electronics                Fax  :  (+64)(3) 359 4632
PO Box 1645 Christchurch        Email : robin.gilks@tait.co.nz
New Zealand

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
