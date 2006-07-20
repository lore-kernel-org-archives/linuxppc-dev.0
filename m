Return-Path: <bwarren@qstreams.com>
Subject: I2C with bus muxes
From: Ben Warren <bwarren@qstreams.com>
To: Linuxppc-embedded@ozlabs.org
Content-Type: text/plain
Date: Thu, 20 Jul 2006 11:16:31 -0400
Message-Id: <1153408592.19682.39.camel@saruman.qstreams.net>
Mime-Version: 1.0
Reply-To: bwarren@qstreams.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,

Has anyone implemented devices like the Philips PCA954x I2C bus muxes
under the /sysfs device model?  I have some optical transponders on my
board that through the wisdom of some committee all have the same fixed
I2C address.  To get around this, we put them behind muxes, creating
'virtual' I2C busses.  I imagine this could be modeled something like
the USB hub model, but that's just a first stab.

regards,
Ben
