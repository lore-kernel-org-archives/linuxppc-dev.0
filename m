Return-Path: <stewart@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 79C4D1A0190
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 18:19:40 +1100 (AEDT)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 8 Feb 2016 00:19:38 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id B912C1FF0043
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  8 Feb 2016 00:07:45 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u187JZwO30212190
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 00:19:35 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u187JZcu020986
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2016 00:19:35 -0700
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V3] powerpc/powernv: Remove support for p5ioc2
In-Reply-To: <1454904500-11218-1-git-send-email-ruscur@russell.cc>
References: <1454904500-11218-1-git-send-email-ruscur@russell.cc>
Date: Mon, 08 Feb 2016 18:19:22 +1100
Message-ID: <87wpqfwtxh.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Russell Currey <ruscur@russell.cc> writes:

> "p5ioc2 is used by approximately 2 machines in the world, and has never
> ever been a supported configuration."
>
> The code for p5ioc2 is essentially unused and complicates what is already
> a very complicated codebase.  Its removal is essentially a "free win" in
> the effort to simplify the powernv PCI code.
>
> In addition, support for p5ioc2 has been dropped from skiboot.  There's no
> reason to keep it around in the kernel.
>
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Yep, it's gone from firmware and there was only ever a handful of
machines inside development labs inside IBM that had it.

We may still have one in the lab, but I agree - it's not worth
maintaining it.

Acked-by: Stewart Smith <stewart@linux.vnet.ibm.com>

-- 
Stewart Smith
OPAL Architect, IBM.
