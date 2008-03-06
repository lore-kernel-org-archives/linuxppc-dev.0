Return-Path: <olof@lixom.net>
Date: Thu, 6 Mar 2008 15:44:06 -0600
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull pasemi.git for-2.6.26 branch
Message-ID: <20080306214406.GA2631@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Please pull from 'for-2.6.26' branch of

  master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.26

to receive the following updates. They have all been posted to the list
previously, and had only minor updates to remove a couple of compiler
warnings:

 arch/powerpc/platforms/pasemi/dma_lib.c |  144 ++++++++++++++
 drivers/net/Makefile                    |    3 
 drivers/net/pasemi_mac.c                |  324 ++++++++++++++++++++++++++------
 drivers/net/pasemi_mac.h                |   35 +++
 drivers/net/pasemi_mac_ethtool.c        |  159 +++++++++++++++
 include/asm-powerpc/pasemi_dma.h        |   77 +++++++
 6 files changed, 681 insertions(+), 61 deletions(-)

Olof Johansson (6):
      pasemi_mac: Move RX/TX section enablement to dma_lib
      [POWERPC] pasemi: Add flag management functions to dma_lib
      [POWERPC] pasemi: Add function engine management functions to dma_lib
      pasemi_mac: jumbo frame support
      pasemi_mac: Enable GSO by default
      pasemi_mac: basic ethtool support
