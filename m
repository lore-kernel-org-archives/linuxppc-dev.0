From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jean-Jacques Levy <Jean-Jacques.Levy@inria.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: airport + dhcp
Date: Sun, 2 Dec 2001 21:37:28 +0100
Message-Id: <20011202203728.19331@smtp.wanadoo.fr>
In-Reply-To: <200112022021.VAA17589@macaron.inria.fr>
References: <200112022021.VAA17589@macaron.inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>Did anybody meet speed problems when connecting an airport to a dhcp
>cable tv ISP?
>
>The speed is then incredibly slow, inducing timeouts for pop servers
>as soon as there are long messages to transfer.
>
>But the speed is quite normal with a real wire connexion between my
>powerbook and the cable tv modem (ie without the airport), when I use
>the same airport with a fixed IP adress at my office. It seems the
>problem happens only when combining airport and dhcp (under linux or
>macos9/10).
>
>I run 2.4.15-ben0 kernel on a pbg4.
>
>Thanks for help.

I'm afraid if the problem also happens with MacOS, it's an issue
with the station firmware. You'd rather report it to apple ;)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
