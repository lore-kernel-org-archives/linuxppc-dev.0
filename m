Return-Path: <albert_herranz@yahoo.es>
Received: from smtp133.mail.ukl.yahoo.com (smtp133.mail.ukl.yahoo.com
	[77.238.184.64]) by ozlabs.org (Postfix) with SMTP id 5ACB3B7D42
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  4 Feb 2010 05:30:56 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org
Subject: [RFC PATCH 0/2] wii: add usb 2.0 support
Date: Wed,  3 Feb 2010 19:30:38 +0100
Message-Id: <1265221840-25634-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The following patch series adds USB 2.0 support for the Wii powerpc
platform via the EHCI controller present in the "Hollywood" chipset
of the video game console.

Albert Herranz (2):
  USB: add HCD_BOUNCE_BUFFERS host controller driver flag
  wii: hollywood ehci controller support

 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 drivers/usb/core/hcd.c                     |  337 +++++++++++++++++++++++-----
 drivers/usb/core/hcd.h                     |   13 +-
 drivers/usb/host/Kconfig                   |    8 +
 drivers/usb/host/ehci-hcd.c                |    5 +
 drivers/usb/host/ehci-hlwd.c               |  227 +++++++++++++++++++
 drivers/usb/host/ehci.h                    |   23 ++
 7 files changed, 550 insertions(+), 64 deletions(-)
 create mode 100644 drivers/usb/host/ehci-hlwd.c
