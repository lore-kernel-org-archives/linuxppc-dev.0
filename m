Return-Path: <joe@perches.com>
Received: from mail.perches.com (mail.perches.com [173.55.12.10])
	by ozlabs.org (Postfix) with ESMTP id 49DA9B6F15
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jul 2010 06:50:35 +1000 (EST)
From: Joe Perches <joe@perches.com>
To: Jiri Kosina <trivial@kernel.org>
Subject: [PATCH 03/36] arch/powerpc: Remove unnecessary casts of private_data
Date: Mon, 12 Jul 2010 13:49:55 -0700
Message-Id: <d0c55635c673debb83f0d45d77e5a5187aea4f2f.1278967120.git.joe@perches.com>
In-Reply-To: <cover.1278967120.git.joe@perches.com>
References: <cover.1278967120.git.joe@perches.com>
Cc: kvm@vger.kernel.org, Marcelo Tosatti <mtosatti@redhat.com>,
	Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Avi Kivity <avi@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/powerpc/kvm/timing.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/kvm/timing.c b/arch/powerpc/kvm/timing.c
index 7037855..46fa04f 100644
--- a/arch/powerpc/kvm/timing.c
+++ b/arch/powerpc/kvm/timing.c
@@ -182,7 +182,7 @@ static ssize_t kvmppc_exit_timing_write(struct file *file,
 	}
 
 	if (c == 'c') {
-		struct seq_file *seqf = (struct seq_file *)file->private_data;
+		struct seq_file *seqf = file->private_data;
 		struct kvm_vcpu *vcpu = seqf->private;
 		/* Write does not affect our buffers previously generated with
 		 * show. seq_file is locked here to prevent races of init with
-- 
1.7.1.337.g6068.dirty
