Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E77E61A0076
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 12:18:48 +1000 (AEST)
Received: from /spool/local
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Thu, 21 May 2015 22:18:45 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id C6CD46E803C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 22:10:30 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4M2Ig1958523696
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 May 2015 02:18:42 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4M2IgVR031385
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 22:18:42 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Jeremy Kerr <jk@ozlabs.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/3 v2] powerpc/powernv: Add opal-prd channel
In-Reply-To: <1432092213.630344.947105758608.3.gpush@pablo>
References: <1432092213.630344.947105758608.3.gpush@pablo>
Date: Fri, 22 May 2015 12:18:40 +1000
Message-ID: <m34mn5mk1r.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Jeremy Kerr <jk@ozlabs.org> writes:

> This change adds a char device to access the "PRD" (processor runtime
> diagnostics) channel to OPAL firmware.
>
> Includes contributions from Vaidyanathan Srinivasan, Neelesh Gupta &
> Vishal Kulkarni.
>
> Signed-off-by: Neelesh Gupta <neelegup@linux.vnet.ibm.com>
> Signed-off-by: Jeremy Kerr <jk@ozlabs.org>

Firmware bits are merged, available in current stable, skiboot-5.0.2

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
