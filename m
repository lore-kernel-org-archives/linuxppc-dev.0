Return-Path: <kda@linux-powerpc.org>
Received: from mail-yk0-x22e.google.com (mail-yk0-x22e.google.com
 [IPv6:2607:f8b0:4002:c07::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E74B51A030F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Oct 2015 00:17:09 +1100 (AEDT)
Received: by ykft191 with SMTP id t191so361540ykf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Oct 2015 06:17:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
References: <1445863448-5746-1-git-send-email-anju@linux.vnet.ibm.com>
Date: Mon, 26 Oct 2015 16:17:06 +0300
Message-ID: <CAOJe8K2FPkWMYPPX+aSNE01pQc6E9w7B0GVMHB8H4QfOvteDoA@mail.gmail.com>
Subject: Re: [PATCH V2 0/3] perf/powerpc:Add ability to sample intr machine
 state in powerpc
From: Denis Kirjanov <kda@linux-powerpc.org>
To: Anju T <anju@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 maddy@linux.vnet.ibm.com, acme@redhat.com, hemant@linux.vnet.ibm.com,
 dsahern@gmail.com, naveen.n.rao@linux.vnet.ibm.com,
 sukadev@linux.vnet.ibm.com, jolsa@redhat.com, khandual@linux.vnet.ibm.com
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/26/15, Anju T <anju@linux.vnet.ibm.com> wrote:
> This short patch series add the ability to sample the interrupted
> machine state for each hardware sample

Hi,
how can we check your patch series without testing details?

>
> Anju (3):
>   perf/powerpc:add ability to sample intr machine state in power
>   tools/perf:Map the ID values with register names
>   perf/powerpc:add support for sampling intr machine state
>
>
>  arch/powerpc/Kconfig                        |   1 +
>  arch/powerpc/include/uapi/asm/perf_regs.h   |  55 +++++++++++++
>  arch/powerpc/perf/Makefile                  |   1 +
>  arch/powerpc/perf/perf_regs.c               |  87 ++++++++++++++++++++
>  tools/perf/arch/powerpc/include/perf_regs.h | 118
> ++++++++++++++++++++++++++++
>  tools/perf/config/Makefile                  |   5 ++
>  6 files changed, 267 insertions(+)
>  create mode 100644 arch/powerpc/include/uapi/asm/perf_regs.h
>  create mode 100644 arch/powerpc/perf/perf_regs.c
>  create mode 100644 tools/perf/arch/powerpc/include/perf_regs.h
>
> --
> 2.1.0
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
