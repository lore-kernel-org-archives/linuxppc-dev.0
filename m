Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Tue, 10 Jun 2003 17:12:18 +0200
From: Robert Schwebel <robert@schwebel.de>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: init does not run on 405GP system
Message-ID: <20030610151217.GV9379@pengutronix.de>
References: <20030610141047.GU9379@pengutronix.de> <8263E99D-9B54-11D7-8E3D-000A95A0560C@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <8263E99D-9B54-11D7-8E3D-000A95A0560C@us.ibm.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Jun 10, 2003 at 10:02:09AM -0500, Hollis Blanchard wrote:
> That's where I've seen output stop when I've forgotten to put a getty
> on /dev/ttyS0 in /etc/inittab...

But that cannot be the reason why a hello_world does not work and why I
do not see the sys_write() syscall being called at all. Btw, init on my
other rootfs is busybox init. I suppose I should always see someting
useful when init is starting.

Robert
--
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Braunschweiger Str. 79,  31134 Hildesheim, Germany
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
    Phone: +49-5121-28619-0 |  Fax: +49-5121-28619-4

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
