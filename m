Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryMDc2PCzzDqYp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:13:51 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P09Ste124019
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 20:13:48 -0400
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c26nsg57-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 20:13:48 -0400
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 10:13:45 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id A9B0F2CE8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:13:42 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P0DgUq21627076
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:13:42 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P0Dgqv010259
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:13:42 +1000
Date: Mon, 25 Jul 2016 10:13:41 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, gwshan@linux.vnet.ibm.com,
 imunsie@au1.ibm.com
Subject: Re: [PATCH] powerpc/powernv: document cxl dependency on special case
 in pnv_eeh_reset()
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1469171795-9879-1-git-send-email-andrew.donnellan@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469171795-9879-1-git-send-email-andrew.donnellan@au1.ibm.com>
Message-Id: <20160725001341.GA10154@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 22, 2016 at 05:16:35PM +1000, Andrew Donnellan wrote:
>pnv_eeh_reset() has special handling for PEs whose primary bus is the root
>bus or the bus immediately underneath the root port.
>
>The cxl bi-modal card support added in b0b5e5918ad1 ("cxl: Add
>cxl_check_and_switch_mode() API to switch bi-modal cards") relies on this
>behaviour when hot-resetting the CAPI adapter following a mode switch.
>Document this in pnv_eeh_reset() so we don't accidentally break it.
>
>Suggested-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>Signed-off-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
