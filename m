From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>,
	<yellowdog-devel@lists.yellowdoglinux.com>,
	"Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: question on best way to install other ide drives?
Date: Sun, 17 Feb 2002 22:52:04 +0100
Message-Id: <20020217215204.4646@smtp.wanadoo.fr>
In-Reply-To: <p05101401b895b9cbee49@[10.0.0.42]>
References: <p05101401b895b9cbee49@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>(A).  IDE does not do a terribly good job of sharing bus bandwidth
>between two active devices, so the ideal case for performance is one
>IDE bus per device.
>
>That said, you'll never be impacted if your workload never attempts
>to exercise both the slave and master at the same time.

iirc, the sonet has 2 busses.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
