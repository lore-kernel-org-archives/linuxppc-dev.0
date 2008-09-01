Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910808312147u1af19615x3325cd464acc1ba2@mail.gmail.com>
Date: Mon, 1 Sep 2008 00:47:47 -0400
From: "Jon Smirl" <jonsmirl@gmail.com>
To: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	"Sascha Hauer" <s.hauer@pengutronix.de>
Subject: interrupting gpios on mpc5200
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

How do I use an interrupting gpio with this new gpiolib support for
the mpc5200?  gpio_to_irq() doesn't appear to be implemented.  If you
can outline for me how it is supposed to be hooked up I can work on
it.

-- 
Jon Smirl
jonsmirl@gmail.com
