Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E29DE1A08B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Jun 2015 17:08:22 +1000 (AEST)
Date: Sat, 6 Jun 2015 09:08:12 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, mingo@redhat.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 15/19] perf, tools: Support long descriptions with
 perf list
Message-ID: <20150606070812.GA3412@krava.redhat.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433485647-9314-16-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150605102138.GB29934@krava.redhat.com>
 <20150605161926.GU1187@tassilo.jf.intel.com>
 <20150605181645.GA25927@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150605181645.GA25927@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 05, 2015 at 11:16:45AM -0700, Sukadev Bhattiprolu wrote:

SNIP

> | > hum, it should be 'v' , right?
> 
> Good catch. Fixed.
> | 
> | Yes that's right.
> | 
> | Also BTW need to add the new option to the usage line a few lines below.
> 
> How about we do this for consistency with 'perf stat'(and shows the
> long options exactly once with 'perf list -h')?
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index d0f7a18..f800927 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -27,12 +27,12 @@ int cmd_list(int argc, const char **argv, const char *prefi
>                 OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
>                 OPT_BOOLEAN('d', "desc", &desc_flag,
>                             "Print extra event descriptions. --no-desc to not p
> -               OPT_BOOLEAN('d', "long-desc", &long_desc_flag,
> +               OPT_BOOLEAN('v', "long-desc", &long_desc_flag,
>                             "Print longer event descriptions."),
>                 OPT_END()
>         };
>         const char * const list_usage[] = {
> -               "perf list [--no-desc] [hw|sw|cache|tracepoint|pmu|event_glob]"
> +               "perf list [<options>] [hw|sw|cache|tracepoint|pmu|event_glob]"
>                 NULL

sounds good to me, and plus the doc update ;-)

thanks,
jirka
