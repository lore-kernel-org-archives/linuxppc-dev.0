Subject: Re: 2.6.0-test2 -- The Uninorth Agpgart driver code contains no
	author info.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308062144.01342.miles.lane@comcast.net>
References: <200308062144.01342.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1060249896.1077.70.camel@gaston>
Mime-Version: 1.0
Date: 07 Aug 2003 11:51:36 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 2003-08-07 at 06:44, Miles Lane wrote:
> This makes it rather difficult to know who to contact to request
> that the Uninorth support get put into Marcelo's 2.4 tree.
>
> Oh, and there is also no GPL header in those files.

Look at the end of file:

MODULE_AUTHOR("Ben Herrenschmidt & Paul Mackerras");
MODULE_LICENSE("GPL");


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
