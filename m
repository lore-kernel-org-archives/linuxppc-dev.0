Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Thermal control for dual core G5s
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602072206290.2458@g5.osdl.org>
References: <1139377372.8187.16.camel@localhost.localdomain>
	<Pine.LNX.4.64.0602072206290.2458@g5.osdl.org>
Content-Type: text/plain
Date: Wed, 08 Feb 2006 17:38:51 +1100
Message-Id: <1139380731.5003.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	linuxppc64-dev <linuxppc64-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-02-07 at 22:07 -0800, Linus Torvalds wrote:
> 
> On Wed, 8 Feb 2006, Benjamin Herrenschmidt wrote:
> >
> > This patch adds a windfarm module, windfarm_pm112, for the dual core G5s
> > (both 2 and 4 core models), keeping the machine from getting into
> > vacuum-cleaner mode ;)
> 
> This seems to introduce a new warning..
> 
>   arch/powerpc/platforms/83xx/Kconfig:10:
> 	warning: 'select' used by config symbol 'MPC834x_SYS' refer to undefined symbol 'DEFAULT_UIMAGE'

Former is not mine...

>   drivers/macintosh/Kconfig:193:
> 	warning: 'select' used by config symbol 'WINDFARM_PM112' refer to undefined symbol 'I2C_PMAC_SMU'

Ok, looks like I forgot to update the Kconfig for the new i2c driver, it
should select I2C_POWERMAC instead. Do you want a new patch or can you
just fix it there ?

Ben.
