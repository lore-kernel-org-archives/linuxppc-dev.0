Message-Id: <v03110700b44273ab1522@[209.183.132.176]>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 31 Oct 1999 17:40:22 -0500
To: linuxppc-dev@lists.linuxppc.org, Benjamin Herrenschmidt <bh40@calva.net>
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Subject: DMA macserial change seems to have messed up my pppd?
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Comparing Paul's rsync'd stable kernel from about a week or so before
2.2.13 was announced to a more recent version made late last week,
something (the changes in macserial and use of DMA?) has completely made
any ppp session unstable when used with any large, memory hungry
applications which includes Netscape, the JDK, etc.

Prior to the DMA change my ppp connections were always completely stable.

I would like to look at this change and possibly back it out to do some
direct tests to see if it is really my problem.  Unfortunately, I junked my
late 2.2.12 kernel source tree.

Can anyone point me to a diff of latest changes made to the serial code so
that I can back them out and do some testing. (or point me to an older
2.2.12 kernel source tree to make my own diffs)

Having a completely unstable machine when using ppp is not very nice at all.

I think I am beginning to understand how other felt who were experiencing
this all along.

Thanks,

Kevin


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
