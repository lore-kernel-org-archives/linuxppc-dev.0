Return-Path: <rsc@pengutronix.de>
Date: Mon, 9 Jun 2008 23:00:22 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Sascha Hauer <s.hauer@pengutronix.de>
Subject: Re: Comments on device tree for pcm030
Message-ID: <20080609210022.GM10115@pengutronix.de>
References: <9e4733910806081208r1a8d0987j6eab0d73bc446640@mail.gmail.com>
	<20080609091335.GC13036@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <20080609091335.GC13036@pengutronix.de>
Cc: linuxppc-dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 09, 2008 at 11:13:35AM +0200, Sascha Hauer wrote:
> I think partitions shouldn't go into the default device tree, as people
> may have different partitioning.

It is also a chicken-and-egg thing, because the oftree would describe
the partition it is in.

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
