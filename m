Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8E2661A032F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Nov 2015 03:17:34 +1100 (AEDT)
Received: from localhost
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 25 Nov 2015 09:17:32 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id B14616E8067
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 11:05:37 -0500 (EST)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAPGHRcv14483534
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 16:17:27 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAPGHQG8001587
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Nov 2015 11:17:26 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] cxl: Fix DSI misses when the context owning task exits
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
Date: Wed, 25 Nov 2015 10:17:09 -0600
Cc: linuxppc-dev@lists.ozlabs.org, imunsie@au1.ibm.com,
 Frank Haverkamp <HAVERKAM@de.ibm.com>
Message-Id: <831E775E-BA10-4ADD-92BA-0A548F1554B7@linux.vnet.ibm.com>
References: <1448362578-32456-1-git-send-email-vaibhav@linux.vnet.ibm.com>
To: Vaibhav Jain <vaibhav@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
