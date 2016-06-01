Return-Path: <andrew.donnellan@au1.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rKF8s0s3dzDqYh
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 12:45:48 +1000 (AEST)
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u512idXX021509
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 22:45:46 -0400
Message-Id: <201606010245.u512idXX021509@mx0a-001b2d01.pphosted.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2395ttba65-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 May 2016 22:45:46 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <andrew.donnellan@au1.ibm.com>;
 Wed, 1 Jun 2016 12:45:43 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id E8CCC2CE805D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Jun 2016 12:45:40 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u512jWRq61669566
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 12:45:40 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u512j89w011434
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Jun 2016 12:45:08 +1000
Subject: Re: [PATCH v10 03/18] powerpc/powernv: Remove PCI_RESET_DELAY_US
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1463726502-14679-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1463726502-14679-4-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: aik@ozlabs.ru, linux-pci@vger.kernel.org, alistair@popple.id.au
From: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Date: Wed, 1 Jun 2016 12:35:23 +1000
MIME-Version: 1.0
In-Reply-To: <1463726502-14679-4-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 20/05/16 16:41, Gavin Shan wrote:
> The macro defined in arch/powerpc/platforms/powernv/pci.c isn't
> used by anyone. Just remove it.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>

Looks like the only user of it disappeared in late 2014...

Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

-- 
Andrew Donnellan              OzLabs, ADL Canberra
andrew.donnellan@au1.ibm.com  IBM Australia Limited
