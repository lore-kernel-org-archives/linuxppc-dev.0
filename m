From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Timothy A. Seufert" <tas@mindspring.com>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: About TAU (and ICTC)
Date: Mon, 20 Aug 2001 00:02:14 +0200
Message-Id: <20010819220214.32000@smtp.wanadoo.fr>
In-Reply-To: <p05100301b7a5c073cc62@[10.0.0.42]>
References: <p05100301b7a5c073cc62@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>The exception would be when it's desired to use the feature for its
>original intended purpose, reduction of die temperature when that
>temperature reaches a critical threshold.  That would also mean using
>the TAU the way it was intended: you set the upper and lower TAU
>thresholds as desired, and the TAU ISR turns ICTC on when the high
>threshold is passed and off when it moves past the lower.

Unfortunately, the TAU is too badly calibrated to be useful. There
_might_ be some other temp sensors in recent Apple machines, on the
I2C bus, I'll do some "probing" one of these days.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
