Return-Path: <arnaldo.melo@gmail.com>
Received: from mail-gh0-f172.google.com (mail-gh0-f172.google.com
 [209.85.160.172])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC0672C0079
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2013 06:44:03 +1100 (EST)
Received: by mail-gh0-f172.google.com with SMTP id z22so650677ghb.31
 for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2013 11:44:00 -0800 (PST)
Sender: Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
Date: Fri, 18 Jan 2013 16:20:32 -0300
From: Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Subject: Re: [PATCH 6/6][v3] perf: Document the ABI of perf sysfs entries
Message-ID: <20130118192032.GB2390@ghostprotocols.net>
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
 Jiri Olsa <jolsa@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Fri, Jan 18, 2013 at 09:46:54AM -0800, Sukadev Bhattiprolu escreveu:
> Jiri Olsa [jolsa@redhat.com] wrote:
> | Maybe it'd worth to mention, that it does not need to be just 'event',
> | but anything from /sys/bus/event_source/devices/<dev>/format directory,
> | like
> | 
> | 		The can be multiple terms like 'event=0xNNNN' specified
> | 		and separated with comma. All available terms are located
> | 		in /sys/bus/event_source/devices/<dev>/format file.
> | 
> | Please feel free to rephrase or use proper English ;-)
> | 
> | otherwise it's ok,
> | jirka
> 
> Agree.  Thanks for the review. Here is the updated patch.

Ok, I'll wait for Jiri's final acked-by, then you can resubmit the patch
series and I'll apply it to my perf/core branch.

- Arnaldo
