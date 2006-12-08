Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [RFC] powerpc: experimental of serial port driver
Date: Fri, 8 Dec 2006 16:12:27 +0100
References: <200612072140.47405.arnd@arndb.de>
	<1165553018.1103.23.camel@localhost.localdomain>
	<1165588888.3328.8.camel@hades.cambridge.redhat.com>
In-Reply-To: <1165588888.3328.8.camel@hades.cambridge.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200612081612.28385.arnd@arndb.de>
Cc: cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 08 December 2006 15:41, David Woodhouse wrote:
> On Fri, 2006-12-08 at 15:43 +1100, Benjamin Herrenschmidt wrote:
> > I'd rather call it 8250_of.c and have it be specific to 8250's.
> 
> Didn't we already do that once?
> 
You submitted a patch once to create a file with the same name,
but different intend, see
http://ozlabs.org/pipermail/linuxppc-dev/2005-August/019464.html

I can't tell if it was ever merged, but it doesn't look like it.
My driver is only meaningful for platforms that use the new style
of_platform_device autoprobing. It will make the serial ports
show up correctly in sysfs, even if they were not detected by
the legacy_serial code we use for 8250 style console ports. This
should be the same thing we do for 8250 PCI ports when the
8250_pci driver.

	Arnd <><
