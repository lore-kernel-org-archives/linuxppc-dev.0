Message-ID: <20001220053326.15976.qmail@ww184.netaddress.usa.net>
Date: 19 Dec 00 23:33:26 CST
From: jeramy b smith <ultrapenguin@netscape.net>
To: Josh Huber <huber@mclx.com>,
        Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: ethernet issue with lombard
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Me too. There are 3 new lines in the bmac driver that are in the dbdma_reset .
Ben added them because what they do is also done in darwin. I haven't had a
chance to downgrade my driver and try though. Running in 100tx mode I have
seen it happen whil my bandwidth utilization was very low. I was actually
actively communication each time it got 'gummed up.'

-jeramy b smith



Josh Huber <huber@mclx.com> wrote:

> ---------------------------------------------
>	Attachment:
>	MIME Type: multipart/signed
> ---------------------------------------------
> So, has anyone else had any problems with ethernet on their lombard?
> I was having trouble with 2.2.18, so I decided to try upgrading to
> 2.4.0-* (the 2_3 bk tree, as of this morning).  I thought the problem
> was fixed, but perhaps I didn't try long enough to break it.
>
> It seems to be easier to kill the network on a 10Mbit connection,
> rather than a 100Mbit connection.
>
> I can kill the network easily with ping -f <ip of local host>
>
> There aren't any helpful messages in any logs (actually, nothing
> relating to ethernet).  No errors are shown in ifconfig eth0.
>
> The only fix seems to be to ifdown/ifup the interface.  Anyone else
> see this?  The ping -f output looks like the following to me:
>
> PING jd.local (192.168.0.1): 56 data bytes
>
.................................................................................................................................................................................................................................................................................................................
> --- jd.local ping statistics ---
> 31706 packets transmitted, 31244 packets received, 1% packet loss
> round-trip min/avg/max = 0.4/19.6/106.8 ms
>
> The packets are returned most of the time, until the dots begin to be
> displayed quickly. (assuming eth0 is broken at this point)  In a
> couple seconds, the dots aren't displayed anymore, so it's unable to
> send data.
>
> hmm?
>
> --
> Josh Huber
> 1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

> ---------------------------------------------
>	Attachment: application/pgp-signature
>	MIME Type: application/pgp-signature
> ---------------------------------------------


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
