From: Benjamin Herrenschmidt <bh40@calva.net>
To: <mittewil@bigfoot.com>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: irda on pismo
Date: Thu, 21 Dec 2000 08:32:37 +0100
Message-Id: <19341115010421.21343@192.168.1.10>
In-Reply-To: <3A417BB1.22F6E226@wolf-359.net>
References: <3A417BB1.22F6E226@wolf-359.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>This is the output when I run the irattach /dev/ttyS1 command. I saw
>that someone posted with this issue but never saw any fix. Any help
>would be appreciated.

I've not looked into this special issue, but I guess you'll run into
another one with irda on this machine: we need some new code for the
pismo to power up/down the IR led (via bits in the KeyLargo ASIC instead
of a PMU command).

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
