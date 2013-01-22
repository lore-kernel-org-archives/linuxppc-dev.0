Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 5B8122C0087
 for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2013 04:11:06 +1100 (EST)
Date: Tue, 22 Jan 2013 18:10:13 +0100
From: Jiri Olsa <jolsa@redhat.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
Message-ID: <20130122171013.GM1037@krava.brq.redhat.com>
References: <20130110010347.GA32590@us.ibm.com>
 <20130110010703.GF32590@us.ibm.com>
 <20130115185759.GG5826@ghostprotocols.net>
 <20130116113013.GA1042@krava.brq.redhat.com>
 <20130116185815.GA3351@us.ibm.com>
 <20130117141145.GA3817@krava.brq.redhat.com>
 <20130118174654.GA12575@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130118174654.GA12575@us.ibm.com>
Cc: Andi Kleen <ak@linux.intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
 robert.richter@amd.com, Greg KH <greg@kroah.com>,
 Anton Blanchard <anton@au1.ibm.com>, linux-kernel@vger.kernel.org,
 Stephane Eranian <eranian@google.com>, linuxppc-dev@ozlabs.org,
 Ingo Molnar <mingo@redhat.com>, Paul Mackerras <paulus@samba.org>,
 Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jan 18, 2013 at 09:46:54AM -0800, Sukadev Bhattiprolu wrote:
> Jiri Olsa [jolsa@redhat.com] wrote:

SNIP

> +
> +Contact:	Linux kernel mailing list <linux-kernel@vger.kernel.org>
> +		Linux Powerpc mailing list <linuxppc-dev@ozlabs.org>
> +
> +Description:	POWER-systems specific performance monitoring events
> +
> +		A collection of performance monitoring events that may be
> +		supported by the POWER CPU. These events can be monitored
> +		using the 'perf(1)' tool.
> +
> +		These events may not be supported by other CPUs.
> +
> +		The contents of each file would look like:
> +
> +			event=0xNNNN
> +
> +		where 'N' is a hex digit and the number '0xNNNN' shows the
> +		"raw code" for the perf event identified by the file's
> +		"basename".
> +
> +		Further, multiple terms like 'event=0xNNNN' can be specified
> +		and separated with comma. All available terms are defined in
> +		the /sys/bus/event_source/devices/<dev>/format file.

Acked-by: Jiri Olsa <jolsa@redhat.com>

thanks,
jirka
