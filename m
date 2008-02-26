Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18371.65529.312001.673609@cargo.ozlabs.ibm.com>
Date: Tue, 26 Feb 2008 23:03:05 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: Patches added to master & powerpc-next branches of powerpc.git
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have created a powerpc-next branch in the powerpc.git tree, which
has the following commits on it so far.  The master branch is at the
same point.  I've pulled in Dave Miller's tree (for the LMB changes)
and applied some other patches from the list.

I'm expecting that platform/subarchitecture maintainers will be
sending me pull requests for their trees from time to time.

Paul.

Anton Vorontsov (1):
      [POWERPC] 8xx: Timebase frequency should not depend on bus-frequency

Badari Pulavarty (1):
      [POWERPC] Add code for removing HPTEs for parts of the linear mapping

Becky Bruce (1):
      [LMB]: Make lmb support large physical addressing

Benjamin Herrenschmidt (1):
      [POWERPC] Fix thinko in cpu_thread_mask_to_cores()

Dale Farnsworth (1):
      [POWERPC] Remove dead code at KernelAltiVec

David S. Miller (2):
      [LIB]: Make PowerPC LMB code generic so sparc64 can use it too.
      [LMB]: Fix bug in __lmb_alloc_base().

Johannes Berg (1):
      [POWERPC] mpic: Make sparse happy

Julia Lawall (1):
      [POWERPC] Use FIELD_SIZEOF in arch/ppc

Kumar Gala (2):
      [LMB]: Fix initial lmb add region with a non-zero base
      [LMB]: Fix lmb_add_region if region should be added at the head
