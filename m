From: Benjamin Herrenschmidt <bh40@calva.net>
To: Giuliano Pochini <pochini@denise.shiny.it>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Stealth port problems
Date: Mon, 31 Jul 2000 20:27:15 +0200
Message-Id: <20000731182715.23487@192.168.1.10>
In-Reply-To: <3986152C.992C3CE8@denise.shiny.it>
References: <3986152C.992C3CE8@denise.shiny.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> >
>> > I think the last two addresses correspond to DMA addresses for all
>> > SCC capable machines so far, so this change should be ok.
>>
>> I had the time to try the patch for just a few minutes. It enables the dma
>> code successfully and it seems to work fine. More testing this night.
>>
>> Tnx !
>
>I confirm. It works fine.

I'm pushing this fix to my rsync 2.2 tree and bk 2.4

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
