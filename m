Return-Path: <mrochs@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF6581A04AF
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Feb 2016 05:14:05 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mrochs@linux.vnet.ibm.com>;
 Wed, 24 Feb 2016 11:14:02 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 3264A1FF0025
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 11:02:09 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1OIDxu032243934
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 11:13:59 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1OIDxLc013972
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Feb 2016 11:13:59 -0700
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: [PATCH] cxl: Fix PSL timebase synchronization detection
From: "Matthew R. Ochs" <mrochs@linux.vnet.ibm.com>
In-Reply-To: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
Date: Wed, 24 Feb 2016 12:13:58 -0600
Cc: imunsie@au1.ibm.com, michael.neuling@au1.ibm.com,
 linuxppc-dev@lists.ozlabs.org
Message-Id: <801CF454-A605-446A-92E6-A947996E2C3D@linux.vnet.ibm.com>
References: <1456334871-30397-1-git-send-email-fbarrat@linux.vnet.ibm.com>
To: Frederic Barrat <fbarrat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Reviewed-by: Matthew R. Ochs <mrochs@linux.vnet.ibm.com>
