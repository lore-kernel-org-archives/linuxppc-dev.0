Return-Path: <dbaryshkov@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 36B85B6F59
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Jun 2011 01:08:05 +1000 (EST)
Received: by fxe23 with SMTP id 23so1317709fxe.15
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Jun 2011 08:08:01 -0700 (PDT)
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH V4 0/2] Add cpufreq driver for Momentum Maple platform
Date: Wed, 29 Jun 2011 19:07:54 +0400
Message-Id: <1309360076-22579-1-git-send-email-dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, cpufreq@vger.kernel.org,
	Dave Jones <davej@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Please merge this patchset, adding a cpufreq driver for Momentum Maple
platform. Changes since V3:

* Add comment regarding power-mode-data
* Adjusted kernel output a bit
* Tied the driver to compatible platforms only (as per
  arch/powerpc/platforms/maple/setup.c)

Dmitry Eremin-Solenikov (2):
      ppc: enable scom access functions on Maple
      Add cpufreq driver for Momentum Maple boards

 arch/powerpc/kernel/misc_64.S   |    4 +-
 drivers/cpufreq/Kconfig         |    5 +
 drivers/cpufreq/Kconfig.powerpc |    7 +
 drivers/cpufreq/Makefile        |    5 +
 drivers/cpufreq/maple-cpufreq.c |  309 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 328 insertions(+), 2 deletions(-)
 create mode 100644 drivers/cpufreq/Kconfig.powerpc
 create mode 100644 drivers/cpufreq/maple-cpufreq.c
