From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: any easy way to force 10/100 nics to 10?
Date: Wed, 24 Oct 2001 03:05:46 +0200
Message-Id: <20011024010546.27196@smtp.wanadoo.fr>
In-Reply-To: <3BD60FF5.24C4B841@mandrakesoft.com>
References: <3BD60FF5.24C4B841@mandrakesoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> My new dsl router seems to hate 100 connections from my 10/100 nics.
>>
>> Is there an easy way to force 10mb speed (a /proc setting?)?
>
>The standard way, in this order, is (a) via ethtool, (b) via mii-tool,
>or (c) using a command line option at kernel boot time.

ethtool support isn't in our network drivers yet. That's something
I started working on for sungem, and will add to bmac at least
later on.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
