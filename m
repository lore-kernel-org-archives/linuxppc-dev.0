From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linuxppc-dev@lists.linuxppc.org>,
	=?ISO-8859-1?Q?Michel=20D=E4nzer?= <michdaen@iiic.ethz.ch>
Cc: <linuxppc-dev@lists.linuxppc.org>
Subject: Re: xgamma
Date: Mon, 31 Dec 2001 16:02:05 +0100
Message-Id: <20011231150205.22353@smtp.noos.fr>
In-Reply-To: <3C306F44.19B82F80@denise.shiny.it>
References: <3C306F44.19B82F80@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>> > > > xgamma has no effect with 2.4.17.
>> > >
>> > > I assume you're talking about aty128fb and running X with Option
>> > > "UseFBDev". Ben seems to have decided not to support this
unfortunately.
>> >
>> > Yep.  Workarounds ?
>>
>> Use an older aty128fb where it at least kinda works
>
>Ok, I'll look for an older one.  btw, why gamma support has been removed ?

It somewhat broken, it was on earlier radeonfb's as well. I'll look into
fixing it when I'm back from vacation. Or you can try adapting the palette
code in recent radeonfb to aty128fb (pretty similar).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
