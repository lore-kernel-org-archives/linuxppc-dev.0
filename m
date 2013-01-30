Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9E8A32C0098
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:09 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 30 Jan 2013 23:10:45 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 751822BB004A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:01 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r0UDIxDh31391964
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:00 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r0UDJ0ST029217
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Jan 2013 00:19:00 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [RFC PATCH 1/3] powerpc: Add support for multiple PTE page fragment
 in PTE page
Date: Wed, 30 Jan 2013 18:48:33 +0530
Message-Id: <1359551916-10321-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

This is the preparatory patchset for supporting THP on powerpc. I am sending this across
so that we can get review on this change.


For full THP support on powerpc, I have an early version that boots and runs few test. But
I am still running into few issues, like Firmware NMI etc. Once those are resolved, I will
clean them up and send the complete patchset. 

IMHO we should NOT be merging this patchset until we have the full THP patchset on the list.
But still it will be nice to get review on the multiple PTE page fragment change. Other
architectures like s390 and sparc do support something similar. The implementation here
closely follows the s390 implementation.


-aneesh
