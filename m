Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BE5352C01BC
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2012 18:29:09 +1000 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 5 Jul 2012 09:01:33 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q658EUkc6423030
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 18:14:31 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q658EUXL026047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2012 18:14:30 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V2 0/9] arch/powerpc: Add 64TB support to ppc64   
Date: Thu,  5 Jul 2012 13:44:09 +0530
Message-Id: <1341476058-5405-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

This patchset include patches for supporting 64TB with ppc64. I haven't booted
this on hardware with 64TB memory yet. But they boot fine on real hardware with
less memory. Changes extend VSID bits to 38 bits for a 256MB segment
and 26 bits for 1TB segments. 

Changes from V1:
* Drop the usage of structure (struct virt_addr) to carry virtual address.
  We now represent virtual address via vpn which is virtual address shifted 
  right 12 bits.

Thanks,
-aneesh
