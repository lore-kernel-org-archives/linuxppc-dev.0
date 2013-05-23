Return-Path: <eranian@google.com>
Received: from mail-oa0-f44.google.com (mail-oa0-f44.google.com
 [209.85.219.44])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E59E32C00AB
 for <linuxppc-dev@ozlabs.org>; Thu, 23 May 2013 23:39:03 +1000 (EST)
Received: by mail-oa0-f44.google.com with SMTP id n12so4417892oag.3
 for <linuxppc-dev@ozlabs.org>; Thu, 23 May 2013 06:39:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1369203761-12649-6-git-send-email-khandual@linux.vnet.ibm.com>
References: <1369203761-12649-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1369203761-12649-6-git-send-email-khandual@linux.vnet.ibm.com>
Date: Thu, 23 May 2013 15:39:01 +0200
Message-ID: <CABPqkBSiqn+xOc80wLjibJ0Y2F9hJZbj+H=_3cJr=_Q4ZkHejg@mail.gmail.com>
Subject: Re: [PATCH 5/5] perf, documentation: Description for conditional
 branch filter
From: Stephane Eranian <eranian@google.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Neuling <mikey@neuling.org>,
 "ak@linux.intel.com" <ak@linux.intel.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Linux PPC dev <linuxppc-dev@ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 22, 2013 at 8:22 AM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> Adding documentation support for conditional branch filter.
>
Reviewed-by: Stephane Eranian <eranian@google.com>

> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
> ---
>  tools/perf/Documentation/perf-record.txt | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
> index d4da111..8b5e1ed 100644
> --- a/tools/perf/Documentation/perf-record.txt
> +++ b/tools/perf/Documentation/perf-record.txt
> @@ -169,12 +169,13 @@ following filters are defined:
>          - any_call: any function call or system call
>          - any_ret: any function return or system call return
>          - ind_call: any indirect branch
> +        - cond: conditional branches
>          - u:  only when the branch target is at the user level
>          - k: only when the branch target is in the kernel
>          - hv: only when the target is at the hypervisor level
>
>  +
> -The option requires at least one branch type among any, any_call, any_ret, ind_call.
> +The option requires at least one branch type among any, any_call, any_ret, ind_call, cond.
>  The privilege levels may be omitted, in which case, the privilege levels of the associated
>  event are applied to the branch filter. Both kernel (k) and hypervisor (hv) privilege
>  levels are subject to permissions.  When sampling on multiple events, branch stack sampling
> --
> 1.7.11.7
>
