Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EF9751A2D87
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:56:24 +1100 (AEDT)
Message-ID: <1448942184.9027.7.camel@ellerman.id.au>
Subject: Re: [PATCH 3/4] powerpc/powernv: remove FW_FEATURE_OPAL and just
 use FW_FEATURE_OPALv3
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Date: Tue, 01 Dec 2015 14:56:24 +1100
In-Reply-To: <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
References: <1448599526-31073-1-git-send-email-stewart@linux.vnet.ibm.com>
 <1448599526-31073-4-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-11-27 at 15:45 +1100, Stewart Smith wrote:

> Long ago, only in the lab, there was OPALv1 and OPALv2. Now there is
> just OPALv3, with nobody ever expecting anything on pre-OPALv3 to
> be cared about or supported by mainline kernels.
> 
> So, let's remove FW_FEATURE_OPAL and instead use FW_FEATURE_OPALv3
> exclusively.

It would be less churn if we did the reverse, ie. removed v3 and just used
FW_FEATURE_OPAL. It would also read better as v3 is the one and only version we
care about, so having it called out everywhere is superfluous.

Or is there a good reason I missed?

cheers
