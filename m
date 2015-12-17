Return-Path: <naveen.n.rao@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A07271A11B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 16:11:20 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <naveen.n.rao@linux.vnet.ibm.com>;
 Thu, 17 Dec 2015 10:41:17 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A92443940049
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:41:14 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tBH5BEkm6750682
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:41:14 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tBH5BDFI001309
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 10:41:14 +0530
Date: Thu, 17 Dec 2015 10:40:28 +0530
From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
To: Wang Nan <wangnan0@huawei.com>
Cc: acme@kernel.org, jolsa@redhat.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, sukadev@linux.vnet.ibm.com
Subject: Re: [RESEND PATCH v4 2/3] tools: Move Makefile.arch from perf/config
 to tools/scripts
Message-ID: <20151217051028.GC21524@naverao1-tp.ibm.com>
References: <1450316632-152513-1-git-send-email-wangnan0@huawei.com>
 <1450316632-152513-3-git-send-email-wangnan0@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1450316632-152513-3-git-send-email-wangnan0@huawei.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2015/12/17 01:43AM, Wang Nan wrote:
> After this patch other directories can use this architecture detector
> without directly including it from perf's directory. Libbpf would
> utilize it to get proper $(ARCH) so it can receive correct uapi include
> directory.
> 
> Signed-off-by: Wang Nan <wangnan0@huawei.com>
> Acked-by: Jiri Olsa <jolsa@kernel.org>
> Tested-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
>  tools/perf/config/Makefile      |  2 +-
>  tools/perf/config/Makefile.arch | 18 ------------------
>  tools/perf/tests/make           |  2 +-
>  tools/scripts/Makefile.arch     | 18 ++++++++++++++++++
>  4 files changed, 20 insertions(+), 20 deletions(-)
>  delete mode 100644 tools/perf/config/Makefile.arch
>  create mode 100644 tools/scripts/Makefile.arch
   ^^^^^^
This is different from your previous version. This should be a file 
rename.

- Naveen
