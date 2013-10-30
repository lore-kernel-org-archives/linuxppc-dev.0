Return-Path: <clg@fr.ibm.com>
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp10.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6679D2C0393
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 31 Oct 2013 00:47:55 +1100 (EST)
Received: from /spool/local
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <clg@fr.ibm.com>;
 Wed, 30 Oct 2013 13:47:51 -0000
Received: from b06cxnps4074.portsmouth.uk.ibm.com
 (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
 by d06dlp02.portsmouth.uk.ibm.com (Postfix) with ESMTP id E5AD22190079
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:46 +0000 (GMT)
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
 [9.149.37.228])
 by b06cxnps4074.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9UDlTll54919276
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 13:47:33 GMT
Received: from d06av02.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av02.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9UDldXX026311
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Oct 2013 07:47:41 -0600
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>
To: benh@kernel.crashing.org
Subject: [PATCH 0/3] nvram fixes
Date: Wed, 30 Oct 2013 14:47:05 +0100
Message-Id: <1383140828-7481-1-git-send-email-clg@fr.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@fr.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

Here are a few fixes for nvram, mostly endian issues. The patches are 
based on 3.12-rc7.

Cedric Le Goater (3):
  powerpc/nvram: scan partitions only once
  powerpc/nvram: fix endian issue when reading the NVRAM size
  powerpc/nvram: fix endian issue when reading the partition length

 arch/powerpc/kernel/nvram_64.c         |   10 ++++++++--
 arch/powerpc/platforms/chrp/nvram.c    |    4 ++--
 arch/powerpc/platforms/pseries/nvram.c |   10 +++++-----
 3 files changed, 15 insertions(+), 9 deletions(-)

Cheers,

C.

-- 
1.7.10.4
