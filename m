Return-Path: <elfring@users.sourceforge.net>
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v497x67VLzDq7q
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Jan 2017 04:00:29 +1100 (AEDT)
To: linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Daniel Axtens <dja@axtens.net>, Geliang Tang <geliangtang@163.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>,
 Paul Gortmaker <paul.gortmaker@windriver.com>,
 Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/8] PowerPC-NVRAM: Fine-tuning for some function
 implementations
Message-ID: <53545d97-6ed5-ff17-384f-82e72b3592f9@users.sourceforge.net>
Date: Thu, 19 Jan 2017 17:52:26 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Thu, 19 Jan 2017 17:41:23 +0100

Some update suggestions were taken into account
from static source code analysis.

Markus Elfring (8):
  Return directly after a failed parameter validation in dev_nvram_write()
  Return directly after a failed kmalloc() in dev_nvram_write()
  Move an assignment for the variable "ret" in dev_nvram_write()
  Return directly after a failed parameter validation in dev_nvram_read()
  Return directly after a failed kmalloc() in dev_nvram_read()
  Delete three error messages for a failed memory allocation
  Improve size determinations in three functions
  Move an assignment for the variable "err" in nvram_scan_partitions()

 arch/powerpc/kernel/nvram_64.c | 63 +++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 41 deletions(-)

-- 
2.11.0
