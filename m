Return-Path: <srs0=oy2m=fq=au1.ibm.com=andrew.donnellan@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zn2lm4DR1zF16l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 16:21:56 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3zn2ll5frxz8svH
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Feb 2018 16:21:55 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3zn2ll19PVz9sVw
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 16:21:54 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w1M5IsRs093332
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 00:21:53 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2g9kc505q5-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Feb 2018 00:21:52 -0500
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Thu, 22 Feb 2018 05:21:50 -0000
Subject: Re: [PATCH v3 1/2] ocxl: Add get_metadata IOCTL to share OCXL
 information to userspace
To: "Alastair D'Silva" <alastair@au1.ibm.com>, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org
Cc: frederic.barrat@fr.ibm.com, arnd@arndb.de, gregkh@linuxfoundation.org,
 "Alastair D'Silva" <alastair@d-silva.org>
References: <20180222030334.14060-1-alastair@au1.ibm.com>
 <20180222041739.27899-1-alastair@au1.ibm.com>
 <20180222041739.27899-2-alastair@au1.ibm.com>
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Thu, 22 Feb 2018 16:21:45 +1100
MIME-Version: 1.0
In-Reply-To: <20180222041739.27899-2-alastair@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <822c937d-b4fa-e7a9-67b4-314f6f8fc810@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 22/02/18 15:17, Alastair D'Silva wrote:
> From: Alastair D'Silva <alastair@d-silva.org>
> 
> Some required information is not exposed to userspace currently (eg. the
> PASID), pass this information back, along with other information which
> is currently communicated via sysfs, which saves some parsing effort in
> userspace.
> 
> Signed-off-by: Alastair D'Silva <alastair@d-silva.org>

Acked-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>


-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
