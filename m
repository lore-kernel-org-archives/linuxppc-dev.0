Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2gRN39lkzDqQn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:38:40 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id 204so7199103pge.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 22:38:40 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Jan 2017 12:08:32 +0530
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <pmac@au1.ibm.com>
Subject: Re: [PATCH] powerpc/icp-opal: Fix missing KVM case and harden replay
Message-ID: <20170117063832.GA8963@dhcp-9-109-223-248.in.ibm.com>
References: <20170116175853.2458-1-benh@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170116175853.2458-1-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 11:58:53AM -0600, Benjamin Herrenschmidt wrote:
> The icp-opal call is missing the code from icp-native to recover
> interrupts snatched by KVM. Without that, when running KVM, we can
> get into a situation where an interrupt is lost and the CPU stuck
> with an elevated CPPR.
> 
> Also harden replay by always checking the return from opal_int_eoi
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---

Looks good to me

Acked-by: Balbir Singh <bsingharora@gmail.com>
