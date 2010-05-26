Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DBFE4B7D1D
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 22:38:29 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4QCaiq0023630
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:36:44 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o4QCcFoU021696
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:38:16 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4QCcFDW003269
	for <linuxppc-dev@ozlabs.org>; Wed, 26 May 2010 06:38:15 -0600
Date: Wed, 26 May 2010 08:38:13 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
Message-ID: <20100526123813.GJ24511@zod.rchland.ibm.com>
References: <1274433088.1931.63.camel@pasglop>
	<20100521102255.GC24511@zod.rchland.ibm.com>
	<1274445754.1931.65.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274445754.1931.65.camel@pasglop>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 21, 2010 at 10:42:34PM +1000, Benjamin Herrenschmidt wrote:
>On Fri, 2010-05-21 at 06:22 -0400, Josh Boyer wrote:
>> On Fri, May 21, 2010 at 07:11:28PM +1000, Benjamin Herrenschmidt wrote:
>> >Hi Linus !
>> >
>> >Here's the powerpc batch for this merge window.
>> >
>> >Most of it is in arch/powerpc, a few powerpc specific drivers are hit
>> >too, including removing one that has been unused (and unselectable in
>> >Kconfig) for a long time (hdpuftrs), probably remains of a long dead
>> >platform.
>> 
>> You missed my updated pull request.  I still have some patches sitting in my
>> -next branch that should go in.
>
>Allright, I'll add them asap. Might have to wait for monday tho.

You still haven't pulled these, so I added another small defconfig change for
Icon.  Very trivial.  Updated diffstat below.

josh

The following changes since commit 99ec28f183daa450faa7bdad6f932364ae325648:
  FUJITA Tomonori (1):
        powerpc: Remove unused 'protect4gb' boot parameter

are available in the git repository at:

  ssh://master.kernel.org/pub/scm/linux/kernel/git/jwboyer/powerpc-4xx.git next

Anatolij Gustschin (1):
      powerpc/44x: icon: select SM502 and frame buffer console support

Benjamin Herrenschmidt (1):
      powerpc/44x: Fix UART clocks on 440SPe

Stefan Roese (2):
      powerpc/44x: Add reset-type to katmai.dts
      powerpc/44x: Add basic ICON PPC440SPe board support

Tirumala Marri (1):
      powerpc/44x: Adding PCI-E support for PowerPC 460SX based SOC.

 arch/powerpc/boot/4xx.c                    |   12 +-
 arch/powerpc/boot/dts/icon.dts             |  447 +++++++++
 arch/powerpc/boot/dts/katmai.dts           |    1 +
 arch/powerpc/boot/dts/redwood.dts          |  122 +++
 arch/powerpc/configs/44x/icon_defconfig    | 1451 ++++++++++++++++++++++++++++
 arch/powerpc/platforms/44x/Kconfig         |   11 +
 arch/powerpc/platforms/44x/ppc44x_simple.c |    3 +-
 arch/powerpc/sysdev/ppc4xx_pci.c           |  119 +++
 arch/powerpc/sysdev/ppc4xx_pci.h           |   58 ++
 9 files changed, 2217 insertions(+), 7 deletions(-)
 create mode 100644 arch/powerpc/boot/dts/icon.dts
 create mode 100644 arch/powerpc/configs/44x/icon_defconfig
