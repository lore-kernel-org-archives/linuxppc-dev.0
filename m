Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E34041A0D94
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 20:21:56 +1000 (AEST)
Date: Fri, 5 Jun 2015 12:21:38 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: mingo@redhat.com, ak@linux.intel.com,
 Michael Ellerman <mpe@ellerman.id.au>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 15/19] perf, tools: Support long descriptions with
 perf list
Message-ID: <20150605102138.GB29934@krava.redhat.com>
References: <1433485647-9314-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1433485647-9314-16-git-send-email-sukadev@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1433485647-9314-16-git-send-email-sukadev@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 04, 2015 at 11:27:23PM -0700, Sukadev Bhattiprolu wrote:

SNIP

> ---
>  tools/perf/builtin-list.c |   11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/perf/builtin-list.c b/tools/perf/builtin-list.c
> index 3f058f7..d0f7a18 100644
> --- a/tools/perf/builtin-list.c
> +++ b/tools/perf/builtin-list.c
> @@ -22,10 +22,13 @@ int cmd_list(int argc, const char **argv, const char *prefix __maybe_unused)
>  {
>  	int i;
>  	bool raw_dump = false;
> +	bool long_desc_flag = false;
>  	struct option list_options[] = {
>  		OPT_BOOLEAN(0, "raw-dump", &raw_dump, "Dump raw events"),
>  		OPT_BOOLEAN('d', "desc", &desc_flag,
>  			    "Print extra event descriptions. --no-desc to not print."),
> +		OPT_BOOLEAN('d', "long-desc", &long_desc_flag,
> +			    "Print longer event descriptions."),

hum, it should be 'v' , right?

jirka
