Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sftVc72cQzDsgc
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 20:47:36 +1000 (AEST)
Date: Thu, 22 Sep 2016 20:47:21 +1000
From: Anton Blanchard <anton@samba.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Work around for enabling CONFIG_CMDLINE on ppc64le
Message-ID: <20160922204721.1447f2d5@kryten>
In-Reply-To: <87d1jw8cba.fsf@concordia.ellerman.id.au>
References: <1474525245-10739-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
 <87d1jw8cba.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> But I can't merge that patch.
> 
> Our options are one or both of:
>  - get GCC fixed and backport the fix to the compilers we care about.
>  - blacklist the broken compiler versions.
> 
> Is there a GCC bug filed for this?

Likely: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=71709

We need confirmation this patch fixes the 6.x issue too and that we need
a backport.

Anton
