Return-Path: <ananth@in.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qgV4z2CVzzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2016 14:30:27 +1000 (AEST)
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ananth@in.ibm.com>;
 Wed, 6 Apr 2016 22:30:24 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 78FDC1FF001E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Apr 2016 22:18:30 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u374ULiu43450414
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 21:30:21 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u374ULJi008224
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 6 Apr 2016 22:30:21 -0600
Date: Thu, 7 Apr 2016 10:00:19 +0530
From: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>,
 Arnaldo Carvalho de Melo <acme@redhat.com>,
 Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>,
 Mark Wielaard <mjw@redhat.com>
Subject: Re: [PATCH 1/2] perf/powerpc: Fix kprobe and kretprobe handling with
 kallsyms
Message-ID: <20160407043019.GD3620@in.ibm.com>
Reply-To: ananth@in.ibm.com
References: <cover.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
 <97bd954477bc7a94e676d3510c6f945ff9c9e0cc.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <97bd954477bc7a94e676d3510c6f945ff9c9e0cc.1459942081.git.naveen.n.rao@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 06, 2016 at 06:02:57PM +0530, Naveen N. Rao wrote:

> +	if (!pev->uprobes && map->dso->symtab_type == DSO_BINARY_TYPE__KALLSYMS)
>  		tev->point.offset += PPC64LE_LEP_OFFSET;

uprobes check against kallsysms? Am I missing something here?

Ananth
