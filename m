Return-Path: <brking@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 958141A0009
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Jul 2014 09:22:00 +1000 (EST)
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 991AF1400D7
 for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2014 09:21:59 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <brking@linux.vnet.ibm.com>;
 Mon, 7 Jul 2014 19:21:56 -0400
Received: from b01cxnp22036.gho.pok.ibm.com (b01cxnp22036.gho.pok.ibm.com
 [9.57.198.26])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id D028E38C803B
 for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2014 19:21:53 -0400 (EDT)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp22036.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s67NLj6Y7209348
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2014 23:21:53 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s67NLK2e003085
 for <linuxppc-dev@ozlabs.org>; Mon, 7 Jul 2014 19:21:21 -0400
Message-ID: <53BB2B5F.6080206@linux.vnet.ibm.com>
Date: Mon, 07 Jul 2014 18:21:03 -0500
From: Brian King <brking@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] ibmvfc: fix little endian issues
References: <1403827435-29522-1-git-send-email-tyreld@linux.vnet.ibm.com>
In-Reply-To: <1403827435-29522-1-git-send-email-tyreld@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 jbottomley@parallels.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/26/2014 07:03 PM, Tyrel Datwyler wrote:
> Added big endian annotations to relevant data structure fields, and necessary
> byte swappings to support little endian builds.

Acked-by: Brian King <brking@linux.vnet.ibm.com>

Thanks,

Brian

-- 
Brian King
Power Linux I/O
IBM Linux Technology Center
