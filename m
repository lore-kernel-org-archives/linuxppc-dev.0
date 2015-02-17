Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2D3571A0A25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 08:16:16 +1100 (AEDT)
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 70C2314021A
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 08:16:15 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 14:16:13 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id B9B683E4003F
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:14:06 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HLG5Fj42860772
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:16:13 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HLFbNI005847
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:15:38 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [RFC PATCH 3/3] powerpc/powernv: Remove unused definitions in
 opal-api.h
In-Reply-To: <1424163715-10370-3-git-send-email-mpe@ellerman.id.au>
References: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
 <1424163715-10370-3-git-send-email-mpe@ellerman.id.au>
Date: Wed, 18 Feb 2015 08:15:18 +1100
Message-ID: <m33864i6jd.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skiboot@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
> This removes definitions in opal-api.h that are completely unused in
> Linux.
>
> For each of these I see three possibilities, 1) we *should* be using
> them in Linux and patches will arrive to do that, 2) they are not used
> but should stay in the header to document the API for some important
> reason, 3) they are not used and needn't be part of the API.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Agree. The diff is now a TODO list for patches.

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
