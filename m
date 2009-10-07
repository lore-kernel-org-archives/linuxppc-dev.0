Return-Path: <grant.likely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
From: Grant Likely <grant.likely@secretlab.ca>
Subject: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
To: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
	Stephen Rothwell <sfr@canb.auug.org.au>, davem@davemloft.net,
	sparclinux@vger.kernel.org, monstr@monstr.eu,
	microblaze-uclinux@itee.uq.edu.au, devicetree-discuss@lists.ozlabs.org
Date: Tue, 06 Oct 2009 22:29:57 -0600
Message-ID: <20091007041007.16890.62194.stgit@angua>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Well, I've got to start somewhere...

So here goes.  I've begun the work to merge and clean up the OF device
tree handling code and this is my first set of patches.  Not fully
tested yet, but I'm getting them out to the lists so that I can start
responding to comments and collecting acks.  This first batch isn't
anything exciting, just a merge of common code

---

Grant Likely (12):
      of: merge of_find_all_nodes() implementations
      of: merge other miscellaneous prototypes
      of: merge of_*_flat_dt*() functions
      of: merge of_node_get(), of_node_put() and of_find_all_nodes()
      of: merge of_read_number() an of_read_ulong()
      of: merge of_node_*_flag() and set_node_proc_entry()
      of: merge struct boot_param_header from Microblaze and PowerPC
      of: add common header for flattened device tree representation
      of: Move OF_IS_DYNAMIC and OF_MARK_DYNAMIC macros to of.h
      of: merge struct device_node
      of: merge phandle, ihandle and struct property
      of: Rework linux/of.h and asm/prom.h include ordering


 arch/microblaze/include/asm/prom.h |  135 +--------------------------------
 arch/microblaze/kernel/prom.c      |   23 ------
 arch/powerpc/include/asm/prom.h    |  147 ------------------------------------
 arch/powerpc/kernel/prom.c         |   23 ------
 arch/sparc/include/asm/prom.h      |   55 -------------
 drivers/of/base.c                  |   26 ++++++
 include/linux/of.h                 |  103 +++++++++++++++++++++++++
 include/linux/of_fdt.h             |   87 +++++++++++++++++++++
 8 files changed, 221 insertions(+), 378 deletions(-)
 create mode 100644 include/linux/of_fdt.h

-- 
Signature
