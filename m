Return-Path: <timur@freescale.com>
Message-ID: <4741A56D.9050808@freescale.com>
Date: Mon, 19 Nov 2007 09:02:05 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: Revisited, audio codec device tree entries.
References: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
In-Reply-To: <9e4733910711181010q50c08d2ek8413af74d58cf0ce@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Smirl wrote:

> In the ALSA SOC model the i2s, codec and ac97 drivers are all generic.
> A fabric driver tells specifically how a generic codec is wired into
> the board. What I haven't been able figure out is how to load the
> right fabric driver.

Do not use the device tree to load the fabric driver!

The layout of the hardware and the relationship between the I2S, I2C, codec, 
and whatever device is determined by *both* the fabric driver and the device 
tree.  The information about the devices itself, and *some* information about 
their relationship is stored in the device tree.  Everything else is in the 
fabric driver.

The design of the device tree is already locked in stone, so to speak.  The DT 
can only store what it is allowed to store.  If there's something more that 
you need, you'll have to put it in the fabric driver.

If I weren't on vacation this week, I'd email you my code.  It's almost done 
and it demonstrates what I'm thinking.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
