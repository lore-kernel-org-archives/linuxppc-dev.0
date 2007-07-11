Return-Path: <khali@linux-fr.org>
Received: from kraid.nerim.net (smtp-103-wednesday.nerim.net [62.4.16.103])
	by ozlabs.org (Postfix) with ESMTP id 6ADEADDF31
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 11 Jul 2007 21:40:23 +1000 (EST)
Date: Wed, 11 Jul 2007 13:40:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Domen Puncer <domen.puncer@telargo.com>
Subject: Re: [PATCH] i2c-mpc: work around missing-9th-clock-pulse bug
Message-ID: <20070711134037.1fe0373e@hyperion.delvare>
In-Reply-To: <20070711063335.GB4375@moe.telargo.com>
References: <20070709071955.GD4186@moe.telargo.com>
	<fa686aa40707090853j6079b0c7rbcff7c449baa15e0@mail.gmail.com>
	<20070710061736.GG4186@moe.telargo.com>
	<fa686aa40707092322v58bbdad0veb0ee2ec00f125b0@mail.gmail.com>
	<20070710144030.3786cbf3@hyperion.delvare>
	<20070711054923.GA4375@moe.telargo.com>
	<fa686aa40707102303k58bae578u7358b932c4721ec0@mail.gmail.com>
	<20070711063335.GB4375@moe.telargo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: i2c@lm-sensors.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Domen,

On Wed, 11 Jul 2007 08:33:35 +0200, Domen Puncer wrote:
> On 11/07/07 00:03 -0600, Grant Likely wrote:
> > I don't think it's a great idea to use a link;  You should copy the
> > important parts into the .c file.  Archives may not be forever, and
> > links cannot be read when offline.  If the text is too long for the
> > middle of the C file; then put the documentation at the top right
> > after the header block.
> 
> And v4:
> <----------- cut ------------->
> 
> Work around a problem reported on:
> http://ozlabs.org/pipermail/linuxppc-embedded/2005-July/019038.html
> Without this patch I2C on mpc5200 becomes unusable after a while.
> Tested on mpc5200 boards by Matthias Fechner and me.
> 
> 
> Signed-off-by: Domen Puncer <domen.puncer@telargo.com>

Applied, thanks.

-- 
Jean Delvare
