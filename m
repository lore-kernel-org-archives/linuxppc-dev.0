Return-Path: <eric@ebiederm.dsl.xmission.com>
Received: from ebiederm.dsl.xmission.com (ebiederm.dsl.xmission.com
	[166.70.28.69])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B396FDDED7
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jan 2007 04:00:27 +1100 (EST)
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: "<Andrew Morton" <akpm@osdl.org>
Subject: [PATCH 10/59] sysctl: dccp remove unnecessary insert_at_head flag
Date: Tue, 16 Jan 2007 09:39:15 -0700
Message-Id: <1168965624939-git-send-email-ebiederm@xmission.com>
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Cc: linux-mips@linux-mips.org, linux-parport@lists.infradead.org,
	heiko.carstens@de.ibm.com, ak@suse.de, linuxppc-dev@ozlabs.org,
	paulus@samba.org, aharkes@cs.cmu.edu, schwidefsky@de.ibm.com,
	tim@cyberelk.net, rtc-linux@googlegroups.com,
	linux-scsi@vger.kernel.org, kurt.hackel@oracle.com,
	coda@cs.cmu.edu, vojtech@suse.cz,
	linuxsh-shmedia-dev@lists.sourceforge.net,
	James.Bottomley@SteelEye.com, clemens@ladisch.de,
	xfs@oss.sgi.com, xfs-masters@oss.sgi.com, andrea@suse.de,
	openipmi-developer@lists.sourceforge.net,
	linux-390@vm.marist.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	a.zummo@towertech.it, tony.luck@intel.com,
	linux-ntfs-dev@lists.sourceforge.net, netdev@vger.kernel.org,
	aia21@cantab.net, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, lethal@linux-sh.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	containers@lists.osdl.org, linux390@de.ibm.com, philb@gnu.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 net/dccp/sysctl.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/dccp/sysctl.c b/net/dccp/sysctl.c
index fdcfca3..3391631 100644
--- a/net/dccp/sysctl.c
+++ b/net/dccp/sysctl.c
@@ -127,7 +127,7 @@ static struct ctl_table_header *dccp_table_header;
 
 int __init dccp_sysctl_init(void)
 {
-	dccp_table_header = register_sysctl_table(dccp_root_table, 1);
+	dccp_table_header = register_sysctl_table(dccp_root_table, 0);
 
 	return dccp_table_header != NULL ? 0 : -ENOMEM;
 }
-- 
1.4.4.1.g278f
