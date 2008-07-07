Return-Path: <krafft@de.ibm.com>
Date: Mon, 7 Jul 2008 11:23:22 +0200
From: Christian Krafft <krafft@de.ibm.com>
To: benh@kernel.crashing.org
Subject: Re: [patch 01/11] powerpc/cell: add support for power button of
	future IBM cell blades
Message-ID: <20080707112322.26a21902@de.ibm.com>
In-Reply-To: <1215407543.8970.61.camel@pasglop>
References: <20080704190535.316377278@arndb.de>
	<20080704190805.638836822@arndb.de>
	<1215407543.8970.61.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	cbe-oss-dev@ozlabs.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 07 Jul 2008 15:12:23 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On Fri, 2008-07-04 at 21:05 +0200, arnd@arndb.de wrote:
> > plain text document attachment
> > (0001-powerpc-cell-add-support-for-power-button-of-future.patch)
> > This patch adds support for the power button on future IBM cell blades.
> > It actually doesn't shut down the machine. Instead it exposes an
> > input device /dev/input/event0 to userspace which sends KEY_POWER
> > if power button has been pressed.
> > haldaemon actually recognizes the button, so a plattform independent acpid
> > replacement should handle it correctly.
> > 
> > Signed-off-by: Christian Krafft <krafft@de.ibm.com>
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > ---
> 
> And what if CONFIG_INPUT=n or m ?
> 
> Cheers,
> Ben.
> 

hm, good point.
Only wrapping with ifdefs will not fix the CONFIG_INPUT=m case.
Have to think about it again, will send an update ...

Cheers,
ck

-- 
Mit freundlichen Gruessen,
kind regards,

Christian Krafft
Linux Kernel Development
IBM Systems & Technology Group
Phone: +49-07031-16-2032

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats:	Martin Jetter
Geschaetsfuehung:		Herbert Kircher
Sitz der Gesellschaft:		Boelingen
Registergericht:		Amtsgericht Stuttgart, HRB 243294
