Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNWyX00d1zDvtB
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 04:03:47 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAMGxFO1136223
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:03:45 -0500
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26vs76vdae-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 12:03:45 -0500
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Tue, 22 Nov 2016 10:03:44 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 38A83C40015
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Nov 2016 10:03:21 -0700 (MST)
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.1 \(3251\))
Subject: Re: [PATCH] cxl: fix coccinelle warnings
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
Date: Tue, 22 Nov 2016 11:03:38 -0600
Cc: linuxppc-dev@lists.ozlabs.org, fbarrat@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
References: <20161122101327.14281-1-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Message-Id: <96122555-FFFA-4A83-93F4-D558CF00BF90@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Nov 22, 2016, at 4:13 AM, Andrew Donnellan =
<andrew.donnellan@au1.ibm.com> wrote:
>=20
> Fix the following coccinelle warnings:
>=20
>    drivers/misc/cxl/debugfs.c:46:0-23: WARNING: fops_io_x64 should be
>        defined with DEFINE_DEBUGFS_ATTRIBUTE
>    drivers/misc/cxl/guest.c:890:5-26: WARNING: Comparison to bool
>    drivers/misc/cxl/irq.c:107:3-23: WARNING: Assignment of bool to 0/1
>    drivers/misc/cxl/native.c:57:2-3: Unneeded semicolon
>    drivers/misc/cxl/native.c:170:2-3: Unneeded semicolon
>=20
> Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
