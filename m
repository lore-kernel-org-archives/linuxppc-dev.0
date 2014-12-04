Return-Path: <dev@codyps.com>
Received: from mail-la0-x229.google.com (mail-la0-x229.google.com
 [IPv6:2a00:1450:4010:c03::229])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9080D1A01DE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Dec 2014 16:36:50 +1100 (AEDT)
Received: by mail-la0-f41.google.com with SMTP id hv19so9205540lab.28
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Dec 2014 21:36:44 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1417572235-8197-7-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1417572235-8197-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1417572235-8197-7-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Thu, 4 Dec 2014 00:36:44 -0500
Message-ID: <CAPoQQ-1mYANQxt0Ld7Qf19fbEaOR0hpcWPg4qrxGAshcgaBKLA@mail.gmail.com>
Subject: Re: [PATCH v5 6/6] powerpc/perf/hv-24x7: Document sysfs event
 description entries
From: Cody P Schafer <dev@codyps.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Michael Ellerman <michaele@au1.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Paul Mackerras <paulus@samba.org>,
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> index 32f3f5f..cf70084 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> @@ -21,3 +21,25 @@ Contact:     Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
> +Contact:       Cody P Schafer <cody@linux.vnet.ibm.com>

Probably want someone else to be the contact here.
