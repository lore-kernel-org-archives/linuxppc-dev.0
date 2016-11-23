Return-Path: <dgibson@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNr9K2PkXzDvg5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 16:14:13 +1100 (AEDT)
From: David Gibson <david@gibson.dropbear.id.au>
To: paulus@samba.org
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 kvm@vger.kernel.org, benh@kernel.crashing.org, aik@ozlabs.ru,
 David Gibson <david@gibson.dropbear.id.au>
Subject: [PATCH 0/2] Preliminary cleanups for HPT resizing
Date: Wed, 23 Nov 2016 16:14:05 +1100
Message-Id: <1479878047-19431-1-git-send-email-david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

I'm still chasing this confusion about the CAS bit to send the real
HPT resizing patches.  However, in the meantime, here are some
preliminary cleanups.

These cleanups stand on their own, although I wrote them in the
context of writing the HPT resizing code, and are prerequisites for
those patches.

David Gibson (2):
  kvm: Move KVM_PPC_PVINFO_FLAGS_EV_IDLE definition next to its
    structure
  powerpc/kvm: Corectly report KVM_CAP_PPC_ALLOC_HTAB

 arch/powerpc/kvm/powerpc.c | 5 ++++-
 include/uapi/linux/kvm.h   | 5 +++--
 2 files changed, 7 insertions(+), 3 deletions(-)

-- 
2.7.4
