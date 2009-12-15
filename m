Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 04BA7B6EF4
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Dec 2009 21:59:47 +1100 (EST)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] PowerPC: const intspec pointers
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912102213m5b2a0092i3c25d73b914ece93@mail.gmail.com>
In-Reply-To: <fa686aa40912102213m5b2a0092i3c25d73b914ece93@mail.gmail.com>
MIME-Version: 1.0
Message-ID: <200912151159.40628.roman.fietze@telemotive.de>
Date: Tue, 15 Dec 2009 11:59:40 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hallo Grant,

On Friday 11 December 2009 07:13:45 Grant Likely wrote:

> BTW, if you're interested, there is a driver for the SCLPC FIFO about
> to be merged into 2.6.33.  It's in Ben's tree waiting to be pulled
> into mainline.

I've had a "look" into it. This means I rewrote it in some parts to
get it running.

=46irst I tried to do it in nice little steps, so the git commits are
clean and simple. But with my knowldege about the SCLPC, the code your
old SCLPC test driver and my 2.4.25 FPGA driver using SCLPS and
BestComm, one of the commits just got a big rewrite including fixes
for quite some bugs.

The driver is now running using DMA TX and RX. Without BestComm it's
running partly. I'm really windering if this code ever ran before?
There are some historical or future items in there like measurement of
the times, a list_header maybe for future request queueing, and so on.

If you or Ben are interested in my work I can post the patches
here. Of course just to get some comments, because the driver can't be
ready in the state it is. The commits would go on top of Ben's next
branch.


Roman

=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
