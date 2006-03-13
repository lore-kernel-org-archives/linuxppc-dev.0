Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id A94B7679E2
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Mar 2006 01:17:21 +1100 (EST)
Message-ID: <44157EEF.5000900@ru.mvista.com>
Date: Mon, 13 Mar 2006 17:17:19 +0300
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH][RFC] ppc32: TEMAC driver for ML403
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Here:
   http://source.mvista.com/~ank/paulus-powerpc/20060309/
is an StGIT patchset against
   516450179454de9e689e0a53ed8f34b896e8651c
   branch 'master' of git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc

virtex-ppc_sys_devices-fix.patch - is the same fix posted by Grant Likely few days ago (only formatting is different),
ppc32_xilinx_edk_temac.patch - the low level code from EDK-7.1i used by the this driver
ppc32_xilinx_edk_temac_mods.patch - few modifications to EDK-7.1i code to get rid of compiling the xparameters.h
   #defines into the driver. These mods should not be needed after EDK-8.1 SP2 is released.
ppc32_xilinx_temac.patch - the linux driver itself
ppc32_xilinx_ml403_temac.patch - modifications to the ML403 platform code to add TEMAC.
temac.paulus-powerpc.20060309.tgz - all the patches put together into a tarball (just in case).
temac.config - .config used.

This is not the final version yet (no MII support; SGDMA is operational, but seems to need some additional work).
And I would probably wait for EDK-8.1 SP2 (up to one month or so) where both the TEMAC IP and the EDK code
should be updated.

But it would be nice to know if there is anything to rework in the current code to get the driver
accepted into linux/kernel/git/paulus/powerpc.git or linux/kernel/git/torvalds/linux-2.6.git tree.

And probably someone could start playing with the current driver now. At least I was able to mount
the root over NFS and to run several netperf tests.


Thanks,
Andrei
