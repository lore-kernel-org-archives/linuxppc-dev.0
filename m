Date: Mon, 26 Mar 2001 05:30:18 +0100
Subject: Re: Sound skips
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Giuliano Pochini <pochini@denise.shiny.it>
Cc: linuxppc-dev@lists.linuxppc.org
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Message-Id: <20010326043028.A162C2F090@apollo.valhalla.net>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> there are a variety of things that can block for between 16 & 300 ms (not
>> necessarily IRQs).
>>
>> what size fragments are you using?
>
> 2K. I have to rise it to 8KB to work fine. My friend with the G4 still have
> very few interruptions even with 8KB.

OK.... if you can't do with such large fragments ....

 You might want to try Andrew Morton's Low-Latency patch (URL:
 http://www.uow.edu.au/~andrewm/linux/schedlat.html#downloads )

it makes things quite a lot better - but we still have a way to go on PPC
before we can achieve sub-ms block-free operation.  Another thing on the
audio TODO list ;-)

let me/us know how you do if you try it (last time I did, the patches
applied cleanly to the PPC BK tree) - you (could at the time) ignore the
x86-specific mods to head.S.

HTH,
Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
