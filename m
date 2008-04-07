Return-Path: <olof@lixom.net>
Date: Mon, 7 Apr 2008 09:30:23 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull 'for-2.6.26' branch of pasemi.git
Message-ID: <20080407143023.GA20474@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, pasemi-linux@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul,

Please pull from 'for-2.6.26' branch of

  master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git for-2.6.26

to receive the following updates. The pasemi_mac ones have been
discussed on netdev and acked by Jeff.

 arch/powerpc/platforms/pasemi/iommu.c |   19 ++++++++----------
 arch/powerpc/sysdev/mpic.c            |    9 +++-----
 drivers/net/pasemi_mac.c              |   35 ++++++++++++++++++++++++++++++++--
 3 files changed, 46 insertions(+), 17 deletions(-)

Nate Case (1):
      pasemi_mac: Netpoll support

Olof Johansson (2):
      pasemi_mac: Jumbo frame bugfixes
      [POWERPC] pasemi: Minor iommu cleanup

Valentine Barshak (1):
      [POWERPC] kexec: MPIC ack interrupts at mpic_teardown_this_cpu()
