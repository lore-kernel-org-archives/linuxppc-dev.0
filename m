Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 68EF3B7D0F
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 07:32:04 +1100 (EST)
Date: Fri, 5 Feb 2010 23:32:01 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>,
	David Brownell <dbrownell@users.sourceforge.net>
Subject: [PATCH v2 0/4] OF GPIO integration for I2C/SPI GPIO chips
Message-ID: <20100205203201.GA32281@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Bill Gatliff <bgat@billgatliff.com>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi all,

Here comes v2. Changes:

- In 'gpiolib: Introduce chip addition/removal notifier', open-coded
  gpio_call_chain().

- In 'of/gpio: Add support for two-stage registration for the
  of_gpio_chips', improved commit message.


David, I think it would be best if these patches could go via powerpc
or OF trees, so your Ack would be highly appreciated.

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
