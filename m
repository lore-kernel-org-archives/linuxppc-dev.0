Return-Path: <SRS0=DNDs=5F=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08719C4332D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 10:49:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CCE620409
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 10:49:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CCE620409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48kLB64cM5zDrQw
	for <linuxppc-dev@archiver.kernel.org>; Fri, 20 Mar 2020 21:49:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=linux.intel.com
 (client-ip=192.55.52.43; helo=mga05.intel.com;
 envelope-from=andriy.shevchenko@linux.intel.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linux.intel.com
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48kKrT4NfpzDrR9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Mar 2020 21:33:59 +1100 (AEDT)
IronPort-SDR: HgKbWDAoq0l/pNjoX29WVW8iOgQloiX8jL31HtCcNwjOoPziBPaVvdHqr0Jv75oFXiC2t/kxNS
 ZfnlFJckIq2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
 by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Mar 2020 03:33:57 -0700
IronPort-SDR: dvyOOwpm3ck0vNEcjFg0Ln9rtXpCUZTdZcp6iT/sMJoJaRldBYM8OWYnTUButP6k1/hcmEEsxM
 R4UhrSvV447g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,284,1580803200"; d="scan'208";a="446612540"
Received: from smile.fi.intel.com (HELO smile) ([10.237.68.40])
 by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2020 03:33:50 -0700
Received: from andy by smile with local (Exim 4.93)
 (envelope-from <andriy.shevchenko@linux.intel.com>)
 id 1jFEyM-00BKoR-Uc; Fri, 20 Mar 2020 12:33:50 +0200
Date: Fri, 20 Mar 2020 12:33:50 +0200
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Michal Suchanek <msuchanek@suse.de>
Subject: Re: [PATCH v12 8/8] MAINTAINERS: perf: Add pattern that matches ppc
 perf to the perf entry.
Message-ID: <20200320103350.GV1922688@smile.fi.intel.com>
References: <20200225173541.1549955-1-npiggin@gmail.com>
 <cover.1584699455.git.msuchanek@suse.de>
 <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b150d01c60bd37705789200d9adee9f1c9b50ce.1584699455.git.msuchanek@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Mark Rutland <mark.rutland@arm.com>,
 Gustavo Luiz Duarte <gustavold@linux.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jiri Olsa <jolsa@redhat.com>, Rob Herring <robh@kernel.org>,
 Michael Neuling <mikey@neuling.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Masahiro Yamada <masahiroy@kernel.org>, Nayna Jain <nayna@linux.ibm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Ingo Molnar <mingo@redhat.com>, Allison Randal <allison@lohutok.net>,
 Jordan Niethe <jniethe5@gmail.com>,
 Valentin Schneider <valentin.schneider@arm.com>, Arnd Bergmann <arnd@arndb.de>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Hari Bathini <hbathini@linux.ibm.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Nicholas Piggin <npiggin@gmail.com>, Claudio Carvalho <cclaudio@linux.ibm.com>,
 Eric Richter <erichte@linux.ibm.com>,
 "Eric W. Biederman" <ebiederm@xmission.com>, linux-fsdevel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>,
 Thiago Jung Bauermann <bauerman@linux.ibm.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, Mar 20, 2020 at 11:20:19AM +0100, Michal Suchanek wrote:
> While at it also simplify the existing perf patterns.
> 

And still missed fixes from parse-maintainers.pl.

I see it like below in the linux-next (after the script)

PERFORMANCE EVENTS SUBSYSTEM
M:      Peter Zijlstra <peterz@infradead.org>
M:      Ingo Molnar <mingo@redhat.com>
M:      Arnaldo Carvalho de Melo <acme@kernel.org>
R:      Mark Rutland <mark.rutland@arm.com>
R:      Alexander Shishkin <alexander.shishkin@linux.intel.com>
R:      Jiri Olsa <jolsa@redhat.com>
R:      Namhyung Kim <namhyung@kernel.org>
L:      linux-kernel@vger.kernel.org
S:      Supported
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
F:      arch/*/events/*
F:      arch/*/events/*/*
F:      arch/*/include/asm/perf_event.h
F:      arch/*/kernel/*/*/perf_event*.c
F:      arch/*/kernel/*/perf_event*.c
F:      arch/*/kernel/perf_callchain.c
F:      arch/*/kernel/perf_event*.c
F:      include/linux/perf_event.h
F:      include/uapi/linux/perf_event.h
F:      kernel/events/*
F:      tools/perf/

> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13080,7 +13080,7 @@ R:	Namhyung Kim <namhyung@kernel.org>
>  L:	linux-kernel@vger.kernel.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git perf/core
>  S:	Supported
> -F:	kernel/events/*
> +F:	kernel/events/
>  F:	include/linux/perf_event.h
>  F:	include/uapi/linux/perf_event.h
>  F:	arch/*/kernel/perf_event*.c
> @@ -13088,8 +13088,8 @@ F:	arch/*/kernel/*/perf_event*.c
>  F:	arch/*/kernel/*/*/perf_event*.c
>  F:	arch/*/include/asm/perf_event.h
>  F:	arch/*/kernel/perf_callchain.c
> -F:	arch/*/events/*
> -F:	arch/*/events/*/*
> +F:	arch/*/events/
> +F:	arch/*/perf/
>  F:	tools/perf/
>  
>  PERFORMANCE EVENTS SUBSYSTEM ARM64 PMU EVENTS

-- 
With Best Regards,
Andy Shevchenko


