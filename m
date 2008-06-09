Return-Path: <rsc@pengutronix.de>
Date: Mon, 9 Jun 2008 23:05:26 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Comments on device tree for pcm030
Message-ID: <20080609210526.GN10115@pengutronix.de>
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>,
	Wolfram Sang <wsa@pengutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jun 08, 2008 at 03:08:33PM -0400, Jon Smirl wrote:
> There should be an i2c entry for the eeprom but I don't know the part
> number for it.

Wolfram has oftree bindings for the new at24 driver which will be used
in combination with this board. For patches, please see the i2c list.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
