Message-ID: <396F61D7.FCBCCB22@wanadoo.fr>
Date: Fri, 14 Jul 2000 20:54:15 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Iain Sandoe <iain@sandoe.co.uk>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Upgraded utils...
References: <200007141730.SAA17219@hyperion.valhalla.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Iain Sandoe wrote:
>
> Hi,
> Since I'm working on 2.4.0-testx I upgraded modutils, e2fsprogs and
> util-linux as suggested... (looking at the changes list).

You compiled util-linux yourself?

> Now I have the following behaviour:
>
> on boot
>
> "cannot access hardware clock by any known method"

Could be /sbin/hwclock is now a binary that was compiled with
util-linux. This doesn't mean it works, though. Better put the old fake
hwclock shell script there ("/sbin/clock -s"). Or is one now supposed to
create /dev/rtc and use it as on any other architecture?

> on damaged boot partition --- 2.4.0-test4 crashes one in three times on
> reboot :-(

Mine doesn't boot at all, so you are more advanced there :-)

> generally heart-stopping behaviour from fsck saying that is cannot find
> things and then dropping me into manual fsck...
>
> Is there something else I need to upgrade? or remove?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
