Message-Id: <200005081816.UAA03482@denx.local.net>
To: "Simon Stapleton" <simon@tufty.co.uk>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Wallstreet Ethernet 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 08 May 2000 17:04:28 BST."
             <957801868.3916e58c8f2c3@rascal.ums.easynet.net>
Date: Mon, 08 May 2000 20:16:56 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <957801868.3916e58c8f2c3@rascal.ums.easynet.net> you wrote:
>
> I was wondering if any progress has been made on the Wallstreet /
> ethernet problems issue that was being discussed a while back?

I haven't seen anybody working on this. After the initial  discussion
(especially  with Benjamin Herrenschmidt) it seems clear that this is
a know problem which can cause Tx packets to become corrupted.

> I'm seeing the same issues - real slow connections, a shedload
> of packet collisions and occasional crashes when the disk is
> grinding.

... and probably corrupted data on outgoing connections.

> I can probably gather some more stats if that would be helpful.

Thanks, but this is probably not necessary - the problem seems clear.

> I'd have a go at hacking the code if I had the time, but I'm working
> 18+ hour days at the moment.  Such is life <sigh>.

Same for me - I don't know enough about the BMAC hardware, and  don't
have time to learn it right now.

I sent a message asking for help to Benjamin Herrenschmidt  and  Paul
Mackerras (on Monday, April 17), but got no reply yet :-(

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Far back in the mists of ancient time, in the great and glorious days
of the former Galactic Empire, life was wild, rich  and  largely  tax
free.         - Douglas Adams, _The Hitchhiker's Guide to the Galaxy_

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
