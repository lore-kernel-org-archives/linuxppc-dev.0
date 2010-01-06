Return-Path: <bgat@billgatliff.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 355CAB6EF3
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 14:51:22 +1100 (EST)
Received: by iwn11 with SMTP id 11so12644756iwn.17
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 19:51:20 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 0/2] Create an of_i2c_gpiochip_add()
Date: Tue,  5 Jan 2010 21:51:36 -0600
Message-Id: <1262749898-19197-1-git-send-email-bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch series creates an of_i2c_gpiochip_add() function, to allow
i2c-based GPIO expanders to work with device tree gpio specifications.

Bill Gatliff (2):
  Create a struct of_i2c_gpio_chip, for i2c-based GPIO devices
  Create an of_i2c_gpiochip_add()

 drivers/of/gpio.c       |   55 +++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/of_gpio.h |   23 +++++++++++++++++++
 2 files changed, 78 insertions(+), 0 deletions(-)
