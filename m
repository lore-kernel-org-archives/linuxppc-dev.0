Subject: Re: linux-2.4-benh -- rsync: failed to connect to
	rsync.penguinppc.org: Connection refused
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Miles Lane <miles.lane@comcast.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200308100818.53106.miles.lane@comcast.net>
References: <200308100818.53106.miles.lane@comcast.net>
Content-Type: text/plain
Message-Id: <1060547946.595.36.camel@gaston>
Mime-Version: 1.0
Date: 10 Aug 2003 22:39:06 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 2003-08-10 at 17:18, Miles Lane wrote:
> rsync -avz rsync.penguinppc.org::linux-2.4-benh .
> rsync: failed to connect to rsync.penguinppc.org: Connection refused
> rsync error: error in socket IO (code 10) at clientserver.c(83)

Some HW problems going on, fixed soon hopefully

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
