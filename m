Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp03.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 09F8EB6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:17:56 +1000 (EST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 Jun 2012 14:06:48 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q5TE9tm5131562
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:09:55 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q5TEHhfM032498
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Jun 2012 00:17:43 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, michael@ellerman.id.au,
 anton@samba.org
Subject: [PATCH -V1 0/9] arch/powerpc: Add 64TB support to ppc64   
Date: Fri, 29 Jun 2012 19:47:28 +0530
Message-Id: <1340979457-26018-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

The patches are not for inclusion. I have few "Verify" tags in the patches for
which I would like closer review.

Thanks,
-aneesh
