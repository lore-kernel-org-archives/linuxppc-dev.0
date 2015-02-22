Return-Path: <dev@codyps.com>
Received: from mail-ie0-x233.google.com (mail-ie0-x233.google.com
 [IPv6:2607:f8b0:4001:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 433901A0D5C
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Feb 2015 08:21:21 +1100 (AEDT)
Received: by iecrp18 with SMTP id rp18so19137616iec.9
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 22 Feb 2015 13:21:18 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1422654363-2035-8-git-send-email-sukadev@linux.vnet.ibm.com>
References: <1422654363-2035-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1422654363-2035-8-git-send-email-sukadev@linux.vnet.ibm.com>
Date: Sun, 22 Feb 2015 16:21:18 -0500
Message-ID: <CAPoQQ-0qXbDD=oi8owb+KpV8M3ttWrdMirNZknwkSGQ8teQVkQ@mail.gmail.com>
Subject: Re: [PATCH v7 7/7] powerpc/perf/hv-24x7: Document sysfs event
 description entries
From: Cody P Schafer <dev@codyps.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux PPC <linuxppc-dev@lists.ozlabs.org>, Jiri Olsa <jolsa@redhat.com>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 30, 2015 at 4:46 PM, Sukadev Bhattiprolu
<sukadev@linux.vnet.ibm.com> wrote:
> From: Cody P Schafer <cody@linux.vnet.ibm.com>
>
> Signed-off-by: Cody P Schafer <cody@linux.vnet.ibm.com>
> Signed-off-by: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
> ---
> Changelog[v6]
>         Update Contact info to Linux on Power Developer list
>
>  .../testing/sysfs-bus-event_source-devices-hv_24x7 | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7 b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> index 32f3f5f..f893337 100644
> --- a/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> +++ b/Documentation/ABI/testing/sysfs-bus-event_source-devices-hv_24x7
> @@ -21,3 +21,25 @@ Contact:     Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
>  Description:
>                 Exposes the "version" field of the 24x7 catalog. This is also
>                 extractable from the provided binary "catalog" sysfs entry.
> +
> +What:          /sys/bus/event_source/devices/hv_24x7/event_descs/<event-name>
> +Date:          February 2014
> +Contact:       Linux on PowerPC Developer List <linuxppc-dev@lists.ozlabs.org>
> +Description:
> +               Provides the description of a particular event as provided by
> +               the firmware. If firmware does not provide a description, no
> +               file will be created.
> +
> +               Note that the event-name lacks the domain suffix appended for
> +               events in the events/ dir.

I'm probably a bit late on this, but:

Please consider removing the need for a user to know about the "domain
suffixes" (which, as far as I know are 24x7 specific).
If anyone else ever wants to add firmware/hardware/kernel provided
event descriptions, they'll need to special case these ones as they
don't match up with the actual event names.
