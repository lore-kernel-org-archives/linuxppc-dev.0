From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steven Hanley <sjh@wibble.net>,
	Linux PPC Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: panic on wakeup in pismo
Date: Fri, 13 Apr 2001 16:05:17 +0200
Message-Id: <20010413140517.28068@mailhost.mipsys.com>
In-Reply-To: <20010413160400.A3535@wibble.net>
References: <20010413160400.A3535@wibble.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>I am using the 2.4.3-pre7-benh from about three days after ben announced he
>had gotten sleep working (I rsynced this source on 29/03/2001 AFAIR)
>
>Anyway with gmac as a module if I modprobe it in, use cat5 network and then
>when finished modprobe -r gmac and then put the laptop to sleep. I get a
>panic, the laptop does not go to sleep, the glowing apple on the lid stays
>lit and the led on the back does not start flashing. If I open the lid again
>I see a mon prompt, but I cant type anything into (probably because the
>keyboard is already disabled or something)
>
>If I dont remove the gmac module the laptop will go to sleep fine.
>
>I dont have this same problem with the airport module (which is why I dont
>see the problem often as I generally use the airport with a cipe link for
>any network access from the laptop (yes the WEP stuff is insecure and stupid
>when there are better alternatives such as cipe available))
>
>If this has been fixed since just say so and I will try the latest rsync of
>benh's kernel tree.

That's possibly a bug, I'll check if I properly remove the sleep notifier
when gmac module is unloaded.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
