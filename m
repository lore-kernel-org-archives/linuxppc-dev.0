Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18765.58426.49381.986612@cargo.ozlabs.ibm.com>
Date: Sun, 21 Dec 2008 17:37:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Commits added to powerpc.git next and master branches
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov (3):
      of: Minor simplification for the of_parse_phandles_with_args()
      of: of_parse_phandles_with_args() learns to differentiate 'hole' cells
      of/gpio: Implement of_gpio_count()

Benjamin Herrenschmidt (10):
      powerpc/4xx: Extended DCR support v2
      powerpc/mm: Split mmu_context handling
      powerpc/mm: Rework context management for CPUs with no hash table
      powerpc/mm: Introduce MMU features
      powerpc/mm: Add SMP support to no-hash TLB handling
      powerpc/mm: Split low level tlb invalidate for nohash processors
      powerpc/44x: No need to mask MSR:CE, ME or DE in _tlbil_va on 440
      powerpc/mm: Runtime allocation of mmu context maps for nohash CPUs
      powerpc/mm: Rework usage of _PAGE_COHERENT/NO_CACHE/GUARDED
      powerpc/44x: 44x TLB doesn't need "Guarded" set for all pages

Brian King (2):
      powerpc: Disable Collaborative Memory Manager for kdump
      powerpc: Add reboot notifier to Collaborative Memory Manager

David Howells (1):
      powerpc: Rename struct vm_region to avoid conflict with NOMMU

Grant Erickson (1):
      powerpc: Const-qualify Device Node Argument to DCR Resource Extent API

Hendrik Brueckner (1):
      hvc_console: Escape magic sysrq key

Nathan Lynch (3):
      powerpc: Add of_find_next_cache_node()
      powerpc: Convert cpu_to_l2cache() to of_find_next_cache_node()
      powerpc: Convert sysfs cache code to of_find_next_cache_node()

Scott Wood (1):
      powerpc/bootwrapper: Use the child-bus #address-cells to decide which range entry to use

Stephen Rothwell (1):
      powerpc/iseries: viodasd needs to depend on CONFIG_BLOCK

Tony Breeds (2):
      powerpc: Protect against NULL pointer deref in phyp-dump code
      powerpc: Pass a valid token to rtas_call() in phyp-dump code
