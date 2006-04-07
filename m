Return-Path: <mgreer@mvista.com>
Received: from gateway-1237.mvista.com (unknown [63.81.120.158])
	by ozlabs.org (Postfix) with ESMTP id ABF5967B71
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  8 Apr 2006 01:16:57 +1000 (EST)
Date: Fri, 7 Apr 2006 08:17:55 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Claus Gindhart <claus.gindhart@kontron-modular.com>
Subject: Re: RTC/I2C on 82xx with Linux 2.6.x
Message-ID: <20060407151755.GA27623@mag.az.mvista.com>
References: <003401c65a1b$915dac90$5201a8c0@GEG2400>
	<200604071057.26265.claus.gindhart@kontron-modular.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200604071057.26265.claus.gindhart@kontron-modular.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, Apr 07, 2006 at 10:57:25AM +0200, Claus Gindhart wrote:
> Laurent,
> 
> attached you find a rtc-driver for 2.6.13.
> I ported it from 2.4 myself, because i didnt find any 2.6-port out in the 
> world.
> the ppc_md-structure entries are initialized within the driver itself. This is 
> propably not 100% consistent with the coding conventions, but it works fro 
> me.
> This i2c-layer can still be used with this driver; i have a LM75 and an EEPROM 
> on the same bus, which i operate via LM-Sensors and the i2c-dev driver.

Note that there is a drivers/rtc directory that new (and old) rtc drivers
should be ported to.

Mark
