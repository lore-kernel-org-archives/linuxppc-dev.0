Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9C52E1A0038
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 00:06:04 +1000 (AEST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id DD51C140D26
 for <linuxppc-dev@ozlabs.org>; Thu,  1 Oct 2015 00:06:03 +1000 (AEST)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 30 Sep 2015 08:04:59 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1CC2C1FF0050
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 07:56:04 -0600 (MDT)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t8UE4sn12949392
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 07:04:55 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t8UE4sQs001469
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Sep 2015 08:04:54 -0600
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2102\))
Subject: Re: [PATCH 3/3] cxl: fix leak of ctx->mapping when releasing kernel
 API contexts
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1443578287-7847-3-git-send-email-andrew.donnellan@au1.ibm.com>
Date: Wed, 30 Sep 2015 09:04:52 -0500
Cc: linuxppc-dev@ozlabs.org, imunsie@au1.ibm.com, mikey@neuling.org,
 vaibhav@linux.vnet.ibm.com
Message-Id: <3D4122CB-0D24-487A-AE21-ABD267CDED0E@linux.vnet.ibm.com>
References: <1443578287-7847-1-git-send-email-andrew.donnellan@au1.ibm.com>
 <1443578287-7847-3-git-send-email-andrew.donnellan@au1.ibm.com>
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
