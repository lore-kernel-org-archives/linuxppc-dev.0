Return-Path: <lenb417@gmail.com>
Received: from mail-qc0-f179.google.com (mail-qc0-f179.google.com
 [209.85.216.179])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D73A22C021D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Nov 2012 17:15:49 +1100 (EST)
Received: by mail-qc0-f179.google.com with SMTP id b14so8210535qcs.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Nov 2012 22:15:47 -0800 (PST)
Sender: Len Brown <lenb417@gmail.com>
Message-ID: <50B45A8A.4040307@kernel.org>
Date: Tue, 27 Nov 2012 01:15:38 -0500
From: Len Brown <lenb@kernel.org>
MIME-Version: 1.0
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] cpuidle: Measure idle state durations with monotonic clock
References: <CAODwPW873M32d9zFT9fpJT9+PuMbz8htzUxdF1TNE+J1zR3jYA@mail.gmail.com>
 <1352944590-8776-1-git-send-email-jwerner@chromium.org>
 <3364211.o5ZCq4Y6Je@vostro.rjw.lan>
In-Reply-To: <3364211.o5ZCq4Y6Je@vostro.rjw.lan>
Content-Type: text/plain; charset=UTF-8
Cc: Kevin Hilman <khilman@ti.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 Trinabh Gupta <g.trinabh@gmail.com>,
 Lists Linaro-dev <linaro-dev@lists.linaro.org>, linux-pm@vger.kernel.org,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-kernel@vger.kernel.org,
 linux-acpi@vger.kernel.org,
 "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
 Julius Werner <jwerner@chromium.org>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Sameer Nanda <snanda@chromium.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>>  drivers/idle/intel_idle.c                       |   14 +-----

Acked-by: Len Brown <len.brown@intel.com>

thanks!
-Len
