From: Benjamin Herrenschmidt <bh40@calva.net>
To: Martin Costabel <costabel@wanadoo.fr>,
        linuxppc-dev
 <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 problems
Date: Fri, 1 Sep 2000 12:57:38 +0200
Message-Id: <20000901105738.4534@mailhost.mipsys.com>
In-Reply-To: <39AF028E.1C024B66@wanadoo.fr>
References: <39AF028E.1C024B66@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>You mean when I type on the local "dead" keyboard? I couldn't test this
>yet, because the machine from which I sshed in was 15 km away at work.
>And after a while I had the bad idea to type "hwclock -r", upon which
>the 6400 was really dead, so I could not test it any further. While I
>observed it, the ADB interrupt did not increase.

Ok, so it looks like Cuda gets dead.

Iain Sandoe recently did work to improve the robustness of the Cuda state
machine. I didn't yet have time to look at his code, but it may be
interesting for you to test his patch.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
