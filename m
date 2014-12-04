Return-Path: <ashutosh.dixit@intel.com>
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
 by lists.ozlabs.org (Postfix) with ESMTP id 7DC151A0C79
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Dec 2014 08:10:19 +1100 (AEDT)
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: Jonathan Corbet <corbet@lwn.net>, Jiri Kosina <jkosina@suse.cz>,
 Jiri Kosina <jkosina@suse.cz>, Peter Foley <pefoley2@pefoley.com>,
 Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH linux-next] Documentation: Build mic/mpssd only for x86_64
Date: Thu,  4 Dec 2014 13:27:29 -0800
Message-Id: <25c04eb72c621fc9bdf0aae25782ff5bad5a4b97.1417728278.git.ashutosh.dixit@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 Siva Yerramreddy <yshivakrishna@gmail.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Sudeep Dutt <sudeep.dutt@intel.com>, Caz Yokoyama <Caz.Yokoyama@intel.com>,
 Ashutosh Dixit <ashutosh.dixit@intel.com>,
 Daniel Borkmann <dborkman@redhat.com>, Nikhil Rao <nikhil.rao@intel.com>,
 linuxppc-dev@lists.ozlabs.org, Jennings <sjennings@variantweb.net>,
 Dan Streetman <ddstreet@ieee.org>,
 Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

mic/mpssd along with MIC drivers are currently only usable on
x86_64. So build mic/mpssd only for x86_64 to avoid build breaks on
big-endian systems.

Reported-by: Daniel Borkmann <dborkman@redhat.com>
Reported-by: Dan Streetman <ddstreet@gmail.com>
Suggested-by: Peter Foley <pefoley2@pefoley.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
---
 Documentation/mic/mpssd/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/mic/mpssd/Makefile b/Documentation/mic/mpssd/Makefile
index 0f31568..f47fe6b 100644
--- a/Documentation/mic/mpssd/Makefile
+++ b/Documentation/mic/mpssd/Makefile
@@ -1,5 +1,5 @@
 # List of programs to build
-hostprogs-y := mpssd
+hostprogs-$(CONFIG_X86_64) := mpssd
 
 mpssd-objs := mpssd.o sysfs.o
 
-- 
2.0.0.rc3.2.g998f840
