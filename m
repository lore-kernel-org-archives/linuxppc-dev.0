In-Reply-To: <3692FB17.A3A22B55@jlc.net>
Date: Wed, 6 Jan 1999 10:59:37 +0100
To: linuxppc-dev@lists.linuxppc.org, Dan Malek <dmalek@jlc.net>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Re: Strange PMAC IDE performance problem
Message-Id: <19990106105937.027001@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Jan 6, 1999, Dan Malek <dmalek@jlc.net> wrote:

>I boot with OF (either floppy or enet) because I don't have an
>easy way to get the kernel into the MacOS system folder.  I have
>hacked the atyfb to force G3 resolution and depth regardless of what
>it finds automatically.

You can either make a little transfer HFS partition that you mount
read/write or use MountX (get the latest version). I will probably write
a linuxdisks-like GPL'ed app too once of those days (less complex than
MountX, it will be easier to get it fully functional with read and write
working).

Another way I use for transfering kernels: netatalk. works great here,
almost nothing to configure.

-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>





[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
