Message-Id: <200010302012.e9UKCU216752@denx.local.net>
To: Benjamin Herrenschmidt <bh40@calva.net>
cc: "Joseph P. Garcia" <jpgarcia@execpc.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: BMAC driver issue addressed? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 30 Oct 2000 19:57:52 +0100."
             <19340924122936.4247@192.168.1.2>
Date: Mon, 30 Oct 2000 21:12:30 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


In message <19340924122936.4247@192.168.1.2> you wrote:
>
> something like that. There is another problem, which is documented in
> Darwin, and which cause the chip to corrupt packets in the chip's send
> queue when there's a collision. The workaround they use is to send
> additional packet datas to the chip from the chip send interrupt instead
> of the DBDMA interrupt, thus preventing more than 1 packet to be queued
> in the chip.

Has this been ever implemented in the Linxu BMAC driver?  All  kernel
versiosn  I've  tested  so far still suffer from that problem. I'd be
more than happy if there was a fix available...

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You can observe a lot just by watchin'.                  - Yogi Berra

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
