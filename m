Return-Path: <daniel@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zjLty4rf8zF1Mk
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 16:15:22 +1100 (AEDT)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1G4PeOk051683
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 23:29:07 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g5kec8h4u-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Feb 2018 23:29:06 -0500
Received: from localhost
 by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <daniel@linux.vnet.ibm.com>;
 Fri, 16 Feb 2018 04:29:04 -0000
Subject: Re: [PATCH] pseries/drmem: Check for zero filled ibm, dynamic-memory
 property.
To: Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: mpe@ellerman.id.au, Cyril Bur <cyrilbur@gmail.com>
References: <151875166139.16739.9174261168457130221.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
From: Daniel Black <daniel@linux.vnet.ibm.com>
Date: Fri, 16 Feb 2018 15:28:59 +1100
MIME-Version: 1.0
In-Reply-To: <151875166139.16739.9174261168457130221.stgit@ltcalpine2-lp14.aus.stglabs.ibm.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <9ffeae0f-6cdf-2ef6-2015-90a845f65dfe@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Looks good to me.

Boots without backtrace.

qemu-system-ppc64 -enable-kvm -cpu POWER8 -m 4G -M pseries -nographic
-vga none -kernel /tmp/vmlinux

qemu-system-ppc64 --version
QEMU emulator version 2.5.0 (Debian 1:2.5+dfsg-5ubuntu10.20)



Tested-by: Daniel Black <daniel@linux.vnet.ibm.com>
