Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A01621A06EE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 00:06:09 +1000 (AEST)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B11F8140D4D
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 00:06:08 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 08:04:31 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 7A06F3E4004F
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 08:04:26 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UE3Ed99896422
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 07:03:14 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UE4PcO030339
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 08:04:26 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 2/3] cxl: fix leak of ctx->irq_bitmap when releasing
 context via kernel API
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443578287-7847-2-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Wed, 30 Sep 2015 09:04:26 -0500
Cc: linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com
Message-Id: <9A4CA953-1D70-4F97-A903-950A551DCEB5@linux.vnet.ibm.com>
References: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1443578287-7847-2-git-send-email-andrew.donnellan@au1.ibm.com>
To: Andrew Donnellan <andrew.donnellan@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
