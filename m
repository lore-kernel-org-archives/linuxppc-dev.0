Return-Path: <torvalds@osdl.org>
Date: Tue, 7 Feb 2006 22:07:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Thermal control for dual core G5s
In-Reply-To: <1139377372.8187.16.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0602072206290.2458@g5.osdl.org>
References: <1139377372.8187.16.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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



On Wed, 8 Feb 2006, Benjamin Herrenschmidt wrote:
>
> This patch adds a windfarm module, windfarm_pm112, for the dual core G5s
> (both 2 and 4 core models), keeping the machine from getting into
> vacuum-cleaner mode ;)

This seems to introduce a new warning..

  arch/powerpc/platforms/83xx/Kconfig:10:
	warning: 'select' used by config symbol 'MPC834x_SYS' refer to undefined symbol 'DEFAULT_UIMAGE'

  drivers/macintosh/Kconfig:193:
	warning: 'select' used by config symbol 'WINDFARM_PM112' refer to undefined symbol 'I2C_PMAC_SMU'


Hmm?

		Linus
