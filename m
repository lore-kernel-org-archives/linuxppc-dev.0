Return-Path: <bgat@billgatliff.com>
Received: from mail-yw0-f198.google.com (mail-yw0-f198.google.com
	[209.85.211.198]) by ozlabs.org (Postfix) with ESMTP id DAF53B6EEE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jan 2010 15:30:16 +1100 (EST)
Received: by ywh36 with SMTP id 36so17448470ywh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 05 Jan 2010 20:30:14 -0800 (PST)
From: Bill Gatliff <bgat@billgatliff.com>
To: linuxppc-dev@ozlabs.org,
	lm-sensors@lm-sensors.org
Subject: [PATCH 0/2] *** SUBJECT HERE ***
Date: Tue,  5 Jan 2010 22:30:34 -0600
Message-Id: <1262752236-1937-2-git-send-email-bgat@billgatliff.com>
In-Reply-To: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
References: <1262752236-1937-1-git-send-email-bgat@billgatliff.com>
Cc: Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

*** BLURB HERE ***

Bill Gatliff (2):
  Use struct of_i2c_gpio_chip instead of raw struct gpio_chip
  Reorder initialization to better support device tree data

 drivers/gpio/pca953x.c |  168 +++++++++++++++++++++++++-----------------------
 1 files changed, 88 insertions(+), 80 deletions(-)
