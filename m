Message-Id: <200009011129.MAA31853@hyperion.valhalla.net>
Date: Fri, 01 Sep 2000 12:29:28 +0100
Subject: Re: 2.4 problems
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>,
        Martin Costabel <costabel@wanadoo.fr>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>>You mean when I type on the local "dead" keyboard? I couldn't test this
>>yet, because the machine from which I sshed in was 15 km away at work.
>>And after a while I had the bad idea to type "hwclock -r", upon which
>>the 6400 was really dead, so I could not test it any further. While I
>>observed it, the ADB interrupt did not increase.
>
> Ok, so it looks like Cuda gets dead.
>
> Iain Sandoe recently did work to improve the robustness of the Cuda state
> machine. I didn't yet have time to look at his code, but it may be
> interesting for you to test his patch.

It's not 2.4.0 (sorry)

- but, you can (a) either wait a few days - and I'll have a go or (b) take a
look at the 2.2.17 one and see (IMHO it shouldn't be difficult - the 2.4.0
via-cuda doesn't look much different from the 2.2.17 one).

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
