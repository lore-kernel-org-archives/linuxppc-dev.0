Subject: Re: 2.6.0-test3-bk35 -- drivers/i2c/i2c-keywest.c:513: error:
	structure has no member named `name'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308201428.05756.miles.lane@comcast.net>
References: <200308201428.05756.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1061425668.759.5.camel@gaston>
Mime-Version: 1.0
Date: 21 Aug 2003 02:27:49 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-08-20 at 23:28, Miles Lane wrote:
>   CC      drivers/i2c/i2c-keywest.o
> drivers/i2c/i2c-keywest.c: In function `create_iface':
> drivers/i2c/i2c-keywest.c:513: error: structure has no member named `name'
> drivers/i2c/i2c-keywest.c:526: error: structure has no member named `name'
> make[2]: *** [drivers/i2c/i2c-keywest.o] Error 1

Linus is currently dropping the driver updates I'm sending, hopefully
this will be fixed soon. You may want to try out the tree at
bk://ppc.bkbits.net/linuxppc-2.5-benh, though be warned that this is
a developement tree, various things may be broken in there at a given
point in time.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
