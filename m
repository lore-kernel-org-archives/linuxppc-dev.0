Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id BD6CCDDDE7
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Dec 2008 05:15:06 +1100 (EST)
Date: Fri, 5 Dec 2008 21:15:03 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH 0/3] Some work to implement of_gpio_count()
Message-ID: <20081205181503.GA9855@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Cc: Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi all,

Few patches are needed to implement of_gpio_count() helper function.

So far there are two potential users for the new helper:

- PPC4xx SPI driver
  http://www.mail-archive.com/linuxppc-dev@ozlabs.org/msg26847.html
  ^^ The driver implements of_num_gpios() by itself. Though its
  implementation has some minor issues with regard to the empty cells.
  We'll convert it to the generic function later (the driver is
  a half way to the mainline, so I don't want to interfere. And it's
  another reason for the "of_gpio_count" name).

- Some MPC83xx SPI work I'm about to send.


Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
