Date: Sun, 10 Aug 2003 14:07:21 -0800
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: linux-2.4-benh -- rsync: failed to connect to rsync.penguinppc.org: Connection refused
Message-ID: <20030810220721.GA19894@plato.local.lan>
References: <200308100818.53106.miles.lane@comcast.net>
Mime-Version: 1.0
In-Reply-To: <200308100818.53106.miles.lane@comcast.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Aug 10, 2003 at 08:18:53AM -0700, Miles Lane wrote:
>
> rsync -avz rsync.penguinppc.org::linux-2.4-benh .
> rsync: failed to connect to rsync.penguinppc.org: Connection refused
> rsync error: error in socket IO (code 10) at clientserver.c(83)

its back up now.

I had to move everything over to a new disk, and didn't want anyone
pushing updates into thier rsync trees only to have the updates
mysteriously disappaer because they occured after that part of the
filesystem was dumped.

reason it took so long was /dev/hda was only getting about 97K per sec
transfer rates anymore.

everything is back up and much much faster.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
