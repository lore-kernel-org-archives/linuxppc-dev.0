From: benh@kernel.crashing.org
To: Matthias Grimm <joker@cymes.de>
Cc: LinuxPPC-Dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: muteing speakers if headphones were plugged in?
Date: Wed, 17 Apr 2002 19:56:26 +0100
Message-Id: <20020417185626.18987@mailhost.mipsys.com>
In-Reply-To: <3CBD9361.4060203@cymes.de>
References: <3CBD9361.4060203@cymes.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Is someone working on that issue to implement it for the other chipsets?

I think the Alsa driver can work on other chipsets. I don't know if
someone is working on it for dmasound, I don't think so.

On these (awacs, burgundy), I think you don't have to register a second
interrupt, the main chip interrupt will be called when the jack state
changes, you can probably act from there. A good source of info is the
darwin source code which contains source code for all of Apple sound
drivers.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
