Return-Path: <mrochs@us.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 397651A01EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Mar 2016 11:29:06 +1100 (AEDT)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A88E140C12
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Mar 2016 11:29:05 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mrochs@us.ibm.com>;
 Mon, 7 Mar 2016 17:29:03 -0700
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 2121C19D8040
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Mar 2016 17:16:57 -0700 (MST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp23034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u280T1eY32112894
 for <linuxppc-dev@ozlabs.org>; Tue, 8 Mar 2016 00:29:01 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u280SxVE004968
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Mar 2016 19:29:00 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH v2 2/2] cxl: add set/get private data to context struct
From: Matt Ochs <mrochs@us.ibm.com>
In-Reply-To: <1457377164-22234-2-git-send-email-imunsie@au.ibm.com>
Date: Mon, 7 Mar 2016 18:28:58 -0600
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Manoj Kumar <kumarmn@us.ibm.com>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Neuling <mikey@neuling.org>
Message-Id: <1DDE350D-C275-414A-B886-B64B8548A637@us.ibm.com>
References: <1457377164-22234-1-git-send-email-imunsie@au.ibm.com>
 <1457377164-22234-2-git-send-email-imunsie@au.ibm.com>
To: Ian Munsie <imunsie@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Mar 7, 2016, at 12:59 PM, Ian Munsie <imunsie@au1.ibm.com> wrote:
> 
> From: Michael Neuling <mikey@neuling.org>
> 
> This provides AFU drivers a means to associate private data with a cxl
> context. This is particularly intended for make the new callbacks for
> driver specific events easier for AFU drivers to use, as they can easily
> get back to any private data structures they may use.
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
> Signed-off-by: Ian Munsie <imunsie@au1.ibm.com>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
