Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18540.41013.722932.726273@cargo.ozlabs.ibm.com>
Date: Thu, 3 Jul 2008 19:47:33 +1000
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: More commits added to powerpc.git master and powerpc-next branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The following patches have been added to the master and powerpc-next
branches of powerpc.git.

Paul.

Kumar Gala (2):
      powerpc: Fix building of feature-fixup tests on ppc32
      powerpc: Fixup lwsync at runtime

Michael Neuling (3):
      powerpc: Fix compile warning in init_thread
      powerpc: Clean up copy_to/from_user for vsx and fpr
      powerpc: Remove old dump_task_* functions

Nathan Fontenot (5):
      powerpc/pseries: Allow phandle to be specified in formats other than decimal
      powerpc/pseries: Use base address to derive starting page frame number
      powerpc/pseries: Update the device tree correctly for drconf memory add/remove
      powerpc/pseries: Split code into helper routines for drconf memory
      powerpc/pseries: Update numa association of hotplug memory add for drconf memory

Tony Breeds (1):
      powerpc: Fix building of arch/powerpc/mm/mem.o when MEMORY_HOTPLUG=y and SPARSEMEM=n
