Return-Path: <dev@codyps.com>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2062D1A03D9
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 07:03:17 +1000 (EST)
Received: by mail-la0-f46.google.com with SMTP id gi9so10585629lab.19
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Sep 2014 14:03:11 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1411586844-21381-11-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1411586844-21381-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1411586844-21381-11-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Tue, 30 Sep 2014 17:03:10 -0400
Message-ID: <CAPoQQ-2YM-2n0ATrzCZqaF2e2a4rh9tus=JayRoVed2DyX=-EQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/10] powerpc/perf/hv-24x7: Document sysfs event
 description entries
From: Cody P Schafer <dev@codyps.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Andi Kleen <ak@linux.intel.com>, Michael Ellerman <michaele@au1.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linux PPC <linuxppc-dev@lists.ozlabs.org>, LKML <linux-kernel@vger.kernel.org>,
 Stephane Eranian <eranian@google.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> +What:          /sys/bus/event_source/devices/hv_24x7/event_descs/<event-name>
> +Date:          February 2014
> +Contact:       Cody P Schafer <cody@linux.vnet.ibm.com>

May want to change this contact email to an address that still works
(perhaps the ppc devel list?)
