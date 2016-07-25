Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ryMJn2qjdzDqYp
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:17:29 +1000 (AEST)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6P09SxO123994
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 20:17:27 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24c26nsk6d-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2016 20:17:26 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Mon, 25 Jul 2016 10:17:24 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 4B76C2BB0045
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:17:22 +1000 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u6P0HMMZ27984008
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:17:22 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u6P0HLi0004456
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 10:17:22 +1000
Date: Mon, 25 Jul 2016 10:17:20 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: "Guilherme G. Piccoli" <gpiccoli@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, ruscur@russell.cc, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, gwshan@linux.vnet.ibm.com
Subject: Re: [PATCH] powerpc/eeh: trivial fix to non-conventional PCI address
 output on EEH log
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1469207129-21842-1-git-send-email-gpiccoli@linux.vnet.ibm.com>
Message-Id: <20160725001720.GB10154@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 22, 2016 at 02:05:29PM -0300, Guilherme G. Piccoli wrote:
>This is a very minor/trivial fix for the output of PCI address on EEH logs.
>The PCI address on "OF node" field currently is using ":" as a separator
>for the function, but the usual separator is ".". This patch changes the
>separator for dot, so the PCI address is printed as usual.
>
>No functional changes were introduced.
>
>Signed-off-by: Guilherme G. Piccoli <gpiccoli@linux.vnet.ibm.com>

Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
