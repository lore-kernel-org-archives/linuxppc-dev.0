Subject: Re: 2.6.6 kernel oops on ifconfig eth0 mtu 1300
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Soeren Sonnenburg <kernel@nn7.de>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1084643442.4708.3.camel@localhost>
References: <1084643442.4708.3.camel@localhost>
Content-Type: text/plain
Message-Id: <1084669527.6444.2.camel@gaston>
Mime-Version: 1.0
Date: Sun, 16 May 2004 11:05:29 +1000
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2004-05-16 at 03:50, Soeren Sonnenburg wrote:
> Hi.
>
> When I have some ethernet connection and then do
> ifconfig eth0 mtu 1300 I get an immediate kernel panic (kernel 2.6.6)
> powerbook g4 15" 1ghz.
>
> (xmon trace (jpeg) on request)

Yes, please, the trace

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
