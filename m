Return-Path: <scottwood@freescale.com>
Date: Fri, 22 Aug 2008 10:58:07 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH 0/3]: Sparc OF I2C support.
Message-ID: <20080822155807.GD13422@ld0162-tx32.am.freescale.net>
References: <20080821.001012.265401427.davem@davemloft.net>
	<20080821163256.GC15669@ld0162-tx32.am.freescale.net>
	<20080821.142134.127315039.davem@davemloft.net>
	<48ADDF86.2040200@freescale.com>
	<fa686aa40808211614q72f6719btd391830abded58f6@mail.gmail.com>
	<9e4733910808211645p27ff2c6ci6dba6f363e9ece15@mail.gmail.com>
	<fa686aa40808211933o72c2da60v557d5a58f2c9d1a7@mail.gmail.com>
	<9e4733910808211939s24f1b2f0tc470aaf3831ebcca@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910808211939s24f1b2f0tc470aaf3831ebcca@mail.gmail.com>
Cc: devicetree-discuss@ozlabs.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	sparclinux@vger.kernel.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 21, 2008 at 10:39:40PM -0400, Jon Smirl wrote:
> I see, the old support needed the drivers to be built-in. The newer
> code dynamically loads the correct i2c driver and set its parameters.
> 
> Did the old code use anything besides compatible?

Yes.

> It would have been using the older i2c system that probed for the
> address.

No, it wouldn't have.  It used glue code to generate i2c_board_info
structs.

> >  See commit id d13ae8620dfdedfa7e9ab6d1eec294adc0516065.

As shown in the above commit id. :-)

-Scott
