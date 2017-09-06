Return-Path: <Joakim.Tjernlund@infinera.com>
Received: from NAM03-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam03on0072.outbound.protection.outlook.com [104.47.41.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xnS2j5ym5zDrKj
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Sep 2017 01:20:44 +1000 (AEST)
From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: UIO memmap of PCi devices not working?
Date: Wed, 6 Sep 2017 15:20:37 +0000
Message-ID: <1504711235.27247.110.camel@infinera.com>
Content-Type: text/plain; charset="iso-8859-15"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Having problems to mmap PCI UIO devices and stumbeled over this page:
 http://billfarrow.blogspot.se/2010/09/userspace-access-to-pci-memory.html
it claims some adjustments are needed for UIO mmap over PCI to work.
These are #if 0 ATM and trying to enable them fails build.

Can this be fixed to at least build again ?
The reason for having #if 0 in the first place appears to be old X servers,
is that still true? Can the special casing be removed now?

 Jocke=
