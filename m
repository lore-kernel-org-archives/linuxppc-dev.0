Return-Path: <ram.n.pai@gmail.com>
Received: from mail-qt0-x243.google.com (mail-qt0-x243.google.com
 [IPv6:2607:f8b0:400d:c0d::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zQKhG0tsPzF0X8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jan 2018 05:29:01 +1100 (AEDT)
Received: by mail-qt0-x243.google.com with SMTP id i1so23262643qtj.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 10:29:01 -0800 (PST)
Sender: Ram Pai <ram.n.pai@gmail.com>
From: Ram Pai <linuxram@us.ibm.com>
To: corbet@lwn.net,
	linux-doc@vger.kernel.org
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 mingo@redhat.com, akpm@linux-foundation.org, dave.hansen@intel.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com, hbabu@us.ibm.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, ebiederm@xmission.com,
 linuxram@us.ibm.com, arnd@arndb.de
Subject: [PATCH v10 0/2] Documentation, powerpc, x86 : Memory Protection Keys
Date: Mon, 22 Jan 2018 10:28:34 -0800
Message-Id: <1516645716-10174-1-git-send-email-linuxram@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Memory protection keys enable applications to protect its
address space from inadvertent access from itself.

This feature is now enabled on powerpc architecture.
The patches moves the documentation to arch neutral directory and 
captures the latest information.

Ram Pai (2):
  Documentation/x86: Move protecton key documentation to arch neutral
    directory
  Documentation/vm: PowerPC specific updates to memory protection keys

 Documentation/vm/protection-keys.txt  |  132 +++++++++++++++++++++++++++++++++
 Documentation/x86/protection-keys.txt |   90 ----------------------
 2 files changed, 132 insertions(+), 90 deletions(-)
 create mode 100644 Documentation/vm/protection-keys.txt
 delete mode 100644 Documentation/x86/protection-keys.txt
