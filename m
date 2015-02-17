Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A0AF1A0071
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 08:15:41 +1100 (AEDT)
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 9AFE71401F0
 for <linuxppc-dev@ozlabs.org>; Wed, 18 Feb 2015 08:15:40 +1100 (AEDT)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Tue, 17 Feb 2015 14:15:38 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D48C719D8040
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:06:45 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08027.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1HLFSgl19857522
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:15:36 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1HLF3DR002968
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Feb 2015 14:15:04 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] powerpc/powernv: Move opal-api.h closer to the
 Skiboot version
In-Reply-To: <1424163715-10370-2-git-send-email-mpe@ellerman.id.au>
References: <1424163715-10370-1-git-send-email-mpe@ellerman.id.au>
 <1424163715-10370-2-git-send-email-mpe@ellerman.id.au>
Date: Wed, 18 Feb 2015 08:14:44 +1100
Message-ID: <m361b0i6kb.fsf@oc8180480414.ibm.com>
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
> This commit gets opal-api.h to mostly match the version in Skiboot as of
> commit ea7d806ab0ba.
>
> The exceptions are things which are not (currently) used in Linux.
>
> Most of this is just whitespace and a few things moving around. I think
> the diff is readable.
>
> Also OpalMessageType became opal_msg_type, requiring a change in the
> Linux code.
>
> Finally Skiboot and Linux disagree on CAPI vs CXL, because CAPI means
> something else in Linux. To handle that we just point the Linux wrapper,
> which is named "cxl" to the OPAL token OPAL_PCI_SET_PHB_CAPI_MODE.
>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
