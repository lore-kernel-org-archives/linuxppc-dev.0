Return-Path: <benh@kernel.crashing.org>
Subject: Re: [RFC] powerpc: experimental of serial port driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200612081612.28385.arnd@arndb.de>
References: <200612072140.47405.arnd@arndb.de>
	<1165553018.1103.23.camel@localhost.localdomain>
	<1165588888.3328.8.camel@hades.cambridge.redhat.com>
	<200612081612.28385.arnd@arndb.de>
Content-Type: text/plain
Date: Sat, 09 Dec 2006 07:50:49 +1100
Message-Id: <1165611049.1103.37.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> I can't tell if it was ever merged, but it doesn't look like it.
> My driver is only meaningful for platforms that use the new style
> of_platform_device autoprobing. It will make the serial ports
> show up correctly in sysfs, even if they were not detected by
> the legacy_serial code we use for 8250 style console ports. This
> should be the same thing we do for 8250 PCI ports when the
> 8250_pci driver.

We sill need to fixup legacy_serial to detect them on opb right ?

Ben.
