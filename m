In-Reply-To: <6.0.1.1.0.20040507120138.01d85d60@192.168.2.1>
References: <6.0.1.1.0.20040507120138.01d85d60@192.168.2.1>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <29EF0B4E-A034-11D8-AAB3-003065F9B7DC@embeddededge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
From: Dan Malek <dan@embeddededge.com>
Subject: Re: Framebuffer driver for LCD controller Epson S1D13305 (aka SED1355)
Date: Fri, 7 May 2004 10:38:10 -0400
To: llandre <r&d2@dave-tech.it>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On May 7, 2004, at 6:06 AM, llandre wrote:

> Anybody knows about some existing drivers for this or similar
> controllers
> to use as starting point?

Did you look at all?  There are drivers for the 1355 and 1356 (and
their 13xxx
variants) in the drivers/video directory.   Due to your comment about
the
address/data bus, it doesn't seem like just having the driver is going
to
help the situation :-)

Good Luck.

	-- Dan


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
