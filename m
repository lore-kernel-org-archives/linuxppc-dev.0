Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E07C1A0071
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 08:12:36 +1100 (AEDT)
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A1AB91401AF
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 08:12:35 +1100 (AEDT)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 14:12:33 -0700
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id 025F2C90043
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 16:03:43 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HLCVwt28377116
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 21:12:31 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HLCVvw019074
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 16:12:31 -0500
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/powernv: Move OPAL API definitions to
 opal-api.h
In-Reply-To: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
References: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
Date: Wed, 18 Feb 2015 08:12:28 +1100
Message-ID: <m38ufwi6o3.fsf@oc8180480414.ibm.com>
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

> We'd like to get to the stage where the OPAL API is defined in a header
> that is identical between Linux and Skiboot.
>
> As step one, split the bits that actually define the API into
> opal-api.h. The Linux specific parts stay in opal.h.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>
