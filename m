Return-Path: <dbaryshkov@gmail.com>
Received: from ey-out-2122.google.com (ey-out-2122.google.com [74.125.78.24])
	by ozlabs.org (Postfix) with ESMTP id 29AB6B7B97
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 00:59:02 +1100 (EST)
Received: by ey-out-2122.google.com with SMTP id 4so1611785eyf.33
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Nov 2009 05:59:00 -0800 (PST)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 0/4] mpc8349emitx: add bindings for GPIO, I2C and leds
Date: Mon, 16 Nov 2009 16:58:50 +0300
Message-Id: <1258379934-32352-1-git-send-email-dbaryshkov@gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Please apply the following patches:

Dmitry Eremin-Solenikov (4):
      mpc8349emitx: add gpio controller declarations
      mpc8349emitx: populate I2C busses
      mpc8349emitx: add OF descriptions of LocalBus devices
      mpc8349emitx: add leds-gpio binding

 arch/powerpc/boot/dts/mpc8349emitx.dts |   82 +++++++++++++++++++++++++++++++-
 1 files changed, 81 insertions(+), 1 deletions(-)
