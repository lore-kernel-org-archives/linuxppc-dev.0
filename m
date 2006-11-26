Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (147.175.241.83.in-addr.dgcsystems.net
	[83.241.175.147]) by ozlabs.org (Postfix) with ESMTP id BA25967C03
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Nov 2006 08:37:16 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Alessandro Zummo'" <alessandro.zummo@towertech.it>
Subject: RE: NTP time sync
Date: Sun, 26 Nov 2006 22:37:10 +0100
Message-ID: <00b301c711a3$07cf3530$020120ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20061126202148.190d5b4b@inspiron>
Cc: akpm@osdl.org, 'Andi Kleen' <ak@muc.de>,
	'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>,
	ralf@linux-mips.org, 'David Brownell' <david-b@pacbell.net>,
	linuxppc-dev@ozlabs.org, lethal@linux-sh.org, paulus@samba.org,
	kkojima@rr.iij4u.or.jp, davem@davemloft.net, rmk@arm.linux.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Alessandro Zummo [mailto:alessandro.zummo@towertech.it] 
> Sent: den 26 november 2006 20:22
> To: Joakim Tjernlund
> 
> On Sun, 26 Nov 2006 12:04:54 +0100
> "Joakim Tjernlund" <joakim.tjernlund@transmode.se> wrote:
> 
> > Looking at rtc-dev.c I don't see a MARJOR number assigned 
> to /dev/rtcN. Seems like
> > it is dynamically allocated to whatever major number that is free.
> > Is that the way it is supposed to be? How do I create a 
> static /dev/rtcN in my /dev
> > directory if the major number isn't fixed?
> > Maybe I am just missing something, feel free to correct me :)
> 
>  udev ;)
> 
>  the concept of static numbers is quite old...

Yes it is old, but is the old way unsupported now? I have an embedded target
which is using the old static /dev directory, do I need to make
it udev aware to use newer features like the rtc subsystem?

 Jocke
