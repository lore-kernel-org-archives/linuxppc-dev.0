Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910807232009o634027cajde78395f95ae95ce@mail.gmail.com>
Date: Wed, 23 Jul 2008 23:09:59 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: ppc-dev <Linuxppc-dev@ozlabs.org>
Subject: Getting GPIO to build again
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I just synced up to linus/master....

  CC      arch/powerpc/platforms/52xx/mpc52xx_gpio.o
In file included from arch/powerpc/platforms/52xx/mpc52xx_gpio.c:22:
include/linux/of_gpio.h:26: error: field 'gc' has incomplete type
include/linux/of_gpio.h: In function 'to_of_gpio_chip':
include/linux/of_gpio.h:34: warning: type defaults to 'int' in
declaration of '__mptr'
include/linux/of_gpio.h:34: warning: initialization from incompatible
pointer type
In file included from include/asm/gpio.h:18,
                 from arch/powerpc/platforms/52xx/mpc52xx_gpio.c:26:
include/asm-generic/gpio.h: At top level:
include/asm-generic/gpio.h:24: error: redefinition of 'gpio_is_valid'
include/linux/gpio.h:24: error: previous definition of 'gpio_is_valid' was here
In file included from arch/powerpc/platforms/52xx/mpc52xx_gpio.c:26:
include/asm/gpio.h:27: error: redefinition of 'gpio_get_value'
include/linux/gpio.h:50: error: previous definition of 'gpio_get_value' was here
include/asm/gpio.h:32: error: redefinition of 'gpio_set_value'
include/linux/gpio.h:57: error: previous definition of 'gpio_set_value' was here
include/asm/gpio.h:37: error: redefinition of 'gpio_cansleep'
include/linux/gpio.h:63: error: previous definition of 'gpio_cansleep' was here
include/asm/gpio.h:45: error: redefinition of 'gpio_to_irq'
include/linux/gpio.h:83: error: previous definition of 'gpio_to_irq' was here
include/asm/gpio.h:50: error: redefinition of 'irq_to_gpio'
include/linux/gpio.h:90: error: previous definition of 'irq_to_gpio' was here
make[2]: *** [arch/powerpc/platforms/52xx/mpc52xx_gpio.o] Error 1
make[1]: *** [arch/powerpc/platforms/52xx] Error 2
make: *** [arch/powerpc/platforms] Error 2


-- 
Jon Smirl
jonsmirl@gmail.com
