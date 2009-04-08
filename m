Return-Path: <galak@kernel.crashing.org>
Message-Id: <53B42D49-C040-442E-8448-7BC3190220A5@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <20090407082052.477328750@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v3 0/5] i2c: i2c-mpc: make I2C bus speed configurable
Date: Wed, 8 Apr 2009 00:11:15 -0500
References: <20090407082052.477328750@denx.de>
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@ozlabs.org,
	linux-i2c@vger.kernel.org, Ben Dooks <ben-linux@fluff.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 7, 2009, at 3:20 AM, Wolfgang Grandegger wrote:

> This patch series makes the I2C bus speed configurable by using the
> I2C node property "clock-frequency". If the property is not defined,
> the old fixed clock settings will be used for backward compatibility.
> The property "fsl,preserve-clocking" allows to inherit the settings
> from the bootloader. Furthermore, it does some cleanup and uses the
> new bindings for the Socrates board:
>
>  i2c: i2c-mpc: various coding style fixes
>  i2c: i2c-mpc: use dev based printout function
>  i2c: i2c-mpc: make I2C bus speed configurable

It looks like Ben picked up these patches.

>  powerpc: i2c-mpc: document new FSL I2C bindings and cleanup
>  powerpc/85xx: i2c-mpc: use new I2C bindings for the Socates board

I would have preferred these two go via me, but it looks like the  
board one got picked up by Ben.  I'll deal with the doc/binding update.
>
> Ben, could you please consider this patch series for inclusion into
> 2.6.30.

- k
