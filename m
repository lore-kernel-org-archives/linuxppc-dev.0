Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 3F80ADDE49
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Aug 2007 04:43:40 +1000 (EST)
Date: Wed, 8 Aug 2007 20:33:52 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Jean Delvare <khali@linux-fr.org>
Subject: Re: [PATCH] i2c-mpc: don't disable I2C module on stop condition.
In-Reply-To: <20070808191913.3e6bb0e6@hyperion.delvare>
Message-ID: <Pine.LNX.4.60.0708082001380.6767@poirot.grange>
References: <20070709071955.GD4186@moe.telargo.com>
	<Pine.LNX.4.60.0707210154330.3946@poirot.grange>
	<20070724051431.GF4529@moe.telargo.com>
	<20070808191913.3e6bb0e6@hyperion.delvare>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>,
	Domen Puncer <domen.puncer@telargo.com>, i2c@lm-sensors.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 8 Aug 2007, Jean Delvare wrote:

> Hi Domen,
> 
> On Tue, 24 Jul 2007 07:14:31 +0200, Domen Puncer wrote:
> > Disabling module on stop doesn't work on some CPUs (ie. mpc8241,
> > as reported by Guennadi Liakhovetski), so remove that.
> > 
> > Disable I2C module on errors/interrupts to prevent it from
> > locking up on mpc5200b.
> > 
> > 
> > Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> > ---
> > Hi!
> > 
> > So I fixed i2c on one board, and broke it on another :-(
> > This patch works on both Guennadi's and mine (hey, it might break
> > a third one!).
> > Jean, can you please push this, if there are no objections
> > and "doesn't work for me" reports.
> 
> Queued for 2.6.23-rc3, thanks. Guennadi, can you please confirm that
> this patch fixes your problem?

Yes, it does. Also tested with i2c bus debugging on and with interrupting 
hwclock, thereby messages

I2C: Interrupted

come, but the controller stays functional. Looks good so far:-)

Acked-by: G. Liakhovetski <g.liakhovetski@gmx.de>

Thanks
Guennadi
---
Guennadi Liakhovetski
