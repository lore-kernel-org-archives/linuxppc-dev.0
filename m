Return-Path: <jwboyer@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 410BE47645
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Oct 2008 22:48:24 +1000 (EST)
Received: by mail-gx0-f21.google.com with SMTP id 14so66258gxk.9
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Oct 2008 05:48:24 -0700 (PDT)
Subject: [PATCH 0/3] Reworked AMCC Arches patches
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Victor Gallardo <vgallardo@amcc.com>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 08:46:04 -0400
Message-Id: <1222865165.12674.2.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org, sr@denx.de
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Victor,

I reworked the Arches patches to fit my 'next' branch.  I don't have an
Arches board though, so I'll need you to test them out.  If they work for you
let me know and I'll include them.

josh

Victor Gallardo (3):
  powerpc/44x: Add AMCC Arches eval board support
  Add AMCC Arches defconfig file
  Add AMCC Arches DTS

 arch/powerpc/boot/dts/arches.dts           |  293 +++++++++++
 arch/powerpc/configs/44x/arches_defconfig  |  765 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig         |   22 +-
 arch/powerpc/platforms/44x/ppc44x_simple.c |    1 +
 4 files changed, 1077 insertions(+), 4 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/arches.dts
 create mode 100644 arch/powerpc/configs/44x/arches_defconfig
