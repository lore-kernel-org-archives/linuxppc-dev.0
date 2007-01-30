Return-Path: <david-b@pacbell.net>
Received: from smtp106.sbc.mail.mud.yahoo.com (smtp106.sbc.mail.mud.yahoo.com
	[68.142.198.205]) by ozlabs.org (Postfix) with SMTP id 4BAC7DDFC2
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Jan 2007 07:02:33 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Kim Phillips <kim.phillips@freescale.com>
Subject: Re: [PATCH] generic RTC support for PPC
Date: Tue, 30 Jan 2007 11:55:46 -0800
References: <20070125073754.GA10004@lixom.net>
	<20070130160340.GA25443@lixom.net>
	<20070130132527.0ee3e9ea.kim.phillips@freescale.com>
In-Reply-To: <20070130132527.0ee3e9ea.kim.phillips@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200701301155.48128.david-b@pacbell.net>
Cc: trini@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, paulus@samba.org,
	Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 30 January 2007 11:25 am, Kim Phillips wrote:
> 
> For the MDS boards, which use the ds1374, I'd rather fix the problem properly
> and add a ds1374 driver to the RTC class.  While Scott Wood (cc'd) has already
> done the port, I believe his patches are pending some patches by David Brownell.  

I can't imagine what such patches would be, unless maybe you're referring to
I2C framework updates that make it follow the driver model and support platform
specific data, like an RTC alarm's IRQ number?  Those will take some time.

Just submit a normal I2C driver for that RTC, and any IRQ capability can be
added later.  (Or as a board-specific patch, which seems to be the normal
solution for I2C, though they won't go upstream.)

- Dave
