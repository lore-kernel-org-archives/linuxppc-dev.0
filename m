Message-ID: <XFMail.010326091745.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii
MIME-Version: 1.0
In-Reply-To: <20010326043028.A162C2F090@apollo.valhalla.net>
Date: Mon, 26 Mar 2001 09:17:45 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Iain Sandoe <iain@sandoe.co.uk>
Subject: Re: Sound skips
Cc: linuxppc-dev@lists.linuxppc.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>> there are a variety of things that can block for between 16 & 300 ms (not
>>> necessarily IRQs).
>>>
>>> what size fragments are you using?
>>
>> 2K. I have to rise it to 8KB to work fine. My friend with the G4 still have
>> very few interruptions even with 8KB.
>
> OK.... if you can't do with such large fragments....
>
>  You might want to try Andrew Morton's Low-Latency patch (URL:
>  http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads )

Ok, I'll try, but this problem regards interrupt latency, not user-space latency.

In the meantime I applied your patch (ints << 10 can't compile
in _core.c and I had to comment them out). It makes no difference.
I was fiddling compiling things and I noticed that one of the
worst offenders is libtool, a script in the root the the xmms source tree. Just
run it to get a 100ms pause. This night I'll check if rt_sigprocmask() keeps
irq disabled. Another thing is console scrolling.


Bye.
    Giuliano Pochini ->)|(<- Shiny Network {AS6665} ->)|(<-


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
