Return-Path: <benh@kernel.crashing.org>
Subject: Re: Deprecating of_platform, the path from here...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200912111625.29674.arnd@arndb.de>
References: <fa686aa40912091406i2ef4e1b2u25c9f46b20786245@mail.gmail.com>
	<20091209.162121.256573183.davem@davemloft.net>
	<fa686aa40912101247k55d56783ge0163dd1da073b49@mail.gmail.com>
	<200912111625.29674.arnd@arndb.de>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 12 Dec 2009 09:19:16 +1100
Message-ID: <1260569956.16132.380.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, devicetree-discuss@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, jk@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> The key to the solution IMHO is the ability to create an of_platform_device
> in a hardcoded way without data from a device tree, like we create a
> platform_device today. All these static of_devices would then be rooted
> in /sys/platform by default, while those that come from a device tree are
> in the hierarchy defined there.

 .../...

But that has the exact same problem as the other approaches proposed,
which is that in order to convert a driver, all the platforms in all
archs that use it need to be converted to use the new mechanisms,
properties etc...

This is going to be really hard since we don't have access to all of
that HW and will introduce huge lag as I can expect the various embedded
platforms maintainers being in no hurry to help initially.

Cheers,
Ben.
