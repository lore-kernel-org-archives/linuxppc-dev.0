Return-Path: <sboyd@codeaurora.org>
Received: from smtp.codeaurora.org (smtp.codeaurora.org [198.145.11.231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C1E8C1A0312
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Sep 2014 08:34:39 +1000 (EST)
Message-ID: <541CAD16.6030309@codeaurora.org>
Date: Fri, 19 Sep 2014 15:24:22 -0700
From: Stephen Boyd <sboyd@codeaurora.org>
MIME-Version: 1.0
To: Sudeep Holla <sudeep.holla@arm.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 04/11] drivers: base: support cpu cache information
 interface to userspace via sysfs
References: <1409763617-17074-1-git-send-email-sudeep.holla@arm.com>
 <1409763617-17074-5-git-send-email-sudeep.holla@arm.com>
In-Reply-To: <1409763617-17074-5-git-send-email-sudeep.holla@arm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 linux-ia64@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 x86@kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 linux-api@vger.kernel.org, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/03/14 10:00, Sudeep Holla wrote:
> From: Sudeep Holla <sudeep.holla@arm.com>
>
> This patch adds initial support for providing processor cache information
> to userspace through sysfs interface. This is based on already existing
> implementations(x86, ia64, s390 and powerpc) and hence the interface is
> intended to be fully compatible.
>
> The main purpose of this generic support is to avoid further code
> duplication to support new architectures and also to unify all the existing
> different implementations.
>
> This implementation maintains the hierarchy of cache objects which reflects
> the system's cache topology. Cache devices are instantiated as needed as
> CPUs come online. The cache information is replicated per-cpu even if they are
> shared. A per-cpu array of cache information maintained is used mainly for
> sysfs-related book keeping.
>
> It also implements the shared_cpu_map attribute, which is essential for
> enabling both kernel and user-space to discover the system's overall cache
> topology.
>
> This patch also add the missing ABI documentation for the cacheinfo sysfs
> interface already, which is well defined and widely used.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Stephen Boyd <sboyd@codeaurora.org>
> Cc: linux-api@vger.kernel.org
> Cc: linux390@de.ibm.com
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-ia64@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-s390@vger.kernel.org
> Cc: x86@kernel.org
>

Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Tested-by: Stephen Boyd <sboyd@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
