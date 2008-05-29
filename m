Return-Path: <olof@lixom.net>
Date: Thu, 29 May 2008 15:10:54 -0500
From: Olof Johansson <olof@lixom.net>
To: paulus@samba.org
Subject: Please pull merge branch of pasemi.git
Message-ID: <20080529201052.GA20087@lixom.net>
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

Please pull from 'merge' branch of

  master.kernel.org:/pub/scm/linux/kernel/git/olof/pasemi.git merge

to receive the following updates for 2.6.26:

 arch/powerpc/configs/pasemi_defconfig |  172 +++++++++++++++++++++-------------
 drivers/pcmcia/electra_cf.c           |    1 
 2 files changed, 112 insertions(+), 61 deletions(-)

Olof Johansson (2):
      electra_cf: Add MODULE_DEVICE_TABLE()
      [POWERPC] pasemi: update pasemi_defconfig, enable electra_cf
