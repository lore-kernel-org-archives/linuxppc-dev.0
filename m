From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Albrecht=20Dre=DF?= <ad@mpifr-bonn.mpg.de>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCMCIA on a Pismo with pcmcia-cs-3.1.24
Date: Mon, 12 Feb 2001 12:08:49 +0100
Message-Id: <19350107044033.16629@mailhost.mipsys.com>
In-Reply-To: <3A87A3F6.6A9CA4C7@mpifr-bonn.mpg.de>
References: <3A87A3F6.6A9CA4C7@mpifr-bonn.mpg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>>         Bus: primary=00, secondary=01, subordinate=01, sec-latency=32
>
>These entries look suspicious, and they do not work for sure with our pismos.

These are correct for a 2.2 kernel. 2.4 will have something like
primary=01, secondary=02, ...

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
