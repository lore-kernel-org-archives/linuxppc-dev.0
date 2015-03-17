Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C23F1A012C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 22:12:53 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 17 Mar 2015 21:12:52 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id B33C22CE8040
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 22:12:49 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t2HBCehK51118152
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 22:12:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t2HBCFt4008424
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 22:12:15 +1100
Message-ID: <55080BEB.6010701@linux.vnet.ibm.com>
Date: Tue, 17 Mar 2015 16:41:39 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Greg Kurz <gkurz@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v3 0/5] VPHN parsing fixes
References: <20150223151412.21565.2251.stgit@bahia.local>
In-Reply-To: <20150223151412.21565.2251.stgit@bahia.local>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/23/2015 08:44 PM, Greg Kurz wrote:
> Michael,
> 
> As suggested in...
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2015-February/124647.html
> 
> ... I repost the whole series with an extra patch to implement selftests
> for VPHN (this is the only change between v2 and v3).
> 
> Please review.

[Including the reworked test case from Michael]

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Tested-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
