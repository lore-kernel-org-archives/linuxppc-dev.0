Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 521C21A07B1
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Sep 2014 11:03:13 +1000 (EST)
Received: from e7.ny.us.ibm.com (e7.ny.us.ibm.com [32.97.182.137])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 7F89F140086
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2014 11:03:12 +1000 (EST)
Received: from /spool/local
 by e7.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 8 Sep 2014 21:03:10 -0400
Received: from b01cxnp23033.gho.pok.ibm.com (b01cxnp23033.gho.pok.ibm.com
 [9.57.198.28])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 61AC238C804A
 for <linuxppc-dev@ozlabs.org>; Mon,  8 Sep 2014 21:03:08 -0400 (EDT)
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
 by b01cxnp23033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s89138H764225320
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Sep 2014 01:03:08 GMT
Received: from d01av02.pok.ibm.com (localhost [127.0.0.1])
 by d01av02.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s89137tV017774
 for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2014 21:03:08 -0400
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: Add macros for the ibm_architecture_vec[] lengths
In-Reply-To: <1409295703-31174-1-git-send-email-mpe@ellerman.id.au>
References: <1409295703-31174-1-git-send-email-mpe@ellerman.id.au>
Date: Tue, 09 Sep 2014 11:03:03 +1000
Message-ID: <m3a969sj08.fsf@oc8180480414.ibm.com>
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

Michael Ellerman <mpe@ellerman.id.au> writes:
> The encoding of the lengths in the ibm_architecture_vec array is
> "interesting" to say the least. It's non-obvious how the number of bytes
> we provide relates to the length value.
>
> In fact we already got it wrong once, see 11e9ed43ca8a "Fix up
> ibm_architecture_vec definition".
>
> So add some macros to make it (hopefully) clearer. These at least have
> the property that the integer present in the code is equal to the number
> of bytes that follows it.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Seems at least as correct as the code was before... so,

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>

(not actually compiled or tested or anything, but my internal C
preprocesser says it looks okay :)
