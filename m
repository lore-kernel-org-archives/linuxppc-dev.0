Subject: Re: pmac: input layer as module and usb keyboard
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Magnus Damm <damm@opensource.se>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <20030209223359.40b8c836.damm@opensource.se>
References: <20030209213031.2b67933e.damm@opensource.se>
	 <1044829048.11918.4.camel@zion.wanadoo.fr>
	 <20030209223359.40b8c836.damm@opensource.se>
Content-Type: text/plain
Message-Id: <1044830388.11918.6.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 09 Feb 2003 23:39:48 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-02-09 at 23:33, Magnus Damm wrote:

> My local 2.4.20 pmac_setup.c has plenty of
> #if defined(CONFIG_BLK_DEV_IDE) || defined(CONFIG_BLK_DEV_IDE_MODULE)
> so you must be very happy.. =)

Heh, I want to get rid of those too, though IDE as a module is
known to be broken in various other ways right now anyway.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
