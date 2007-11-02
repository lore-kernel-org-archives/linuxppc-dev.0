Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910711011901lfe7733aiac972512d1a3ab2d@mail.gmail.com>
Date: Thu, 1 Nov 2007 22:01:58 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "PowerPC dev list" <Linuxppc-dev@ozlabs.org>
Subject: Freescale I2C support and CONFIG_I2C_BOARDINFO
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Freescale I2C support is being constructed as a platform driver in
arch/powerpc/sysdev/fsl_soc.c and protected with #ifdef
CONFIG_I2C_BOARDINFO. Could the I2C support instead be initialized in
drivers/i2c/busses/i2c-mpc.c as an of_platform driver instead? I'm
find it confusing that half my drivers are platform drivers and half
are of_platform drivers. It would also eliminate the need for the
ifdef.

I'll trying coding it up and see if it works.

-- 
Jon Smirl
jonsmirl@gmail.com
