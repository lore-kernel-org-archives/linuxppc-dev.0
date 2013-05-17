Return-Path: <haokexin@gmail.com>
Received: from mail.windriver.com (mail.windriver.com [147.11.1.11])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "mail.windriver.com",
 Issuer "Intel External Basic Issuing CA 3A" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4483B2C0099
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 May 2013 16:59:18 +1000 (EST)
From: Kevin Hao <haokexin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 0/2] two minor cleanup patches for function
 pci_process_bridge_OF_ranges
Date: Fri, 17 May 2013 14:58:40 +0800
Message-ID: <1368773922-19754-1-git-send-email-haokexin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Kevin Hao (2):
  powerpc/pci: remove the stale comments of pci_process_bridge_OF_ranges
  powerpc/pci: remove the unused variables in
    pci_process_bridge_OF_ranges

 arch/powerpc/kernel/pci-common.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

-- 
1.8.1.4
