Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ea0-x234.google.com (mail-ea0-x234.google.com
 [IPv6:2a00:1450:4013:c01::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7DEBD2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jul 2013 20:23:11 +1000 (EST)
Received: by mail-ea0-f180.google.com with SMTP id k10so1398535eaj.11
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 05 Jul 2013 03:23:05 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 5 Jul 2013 12:23:02 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130705102302.GA10227@gmail.com>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130704125700.GM18898@dyad.programming.kicks-ass.net>
Cc: acme@redhat.com, vincent.weaver@maine.edu, Vince Weaver <vince@deater.net>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 paulus@samba.org, xiaoguangrong@linux.vnet.ibm.com,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Peter Zijlstra <peterz@infradead.org> wrote:

> On Thu, Jul 04, 2013 at 10:52:18PM +1000, Michael Ellerman wrote:
> > I don't think it even needs libpfm4, just some csv files in tools/perf
> > would do the trick.
> 
> Right; I think Stephane and Jiri are in favour of creating a 'new' 
> project that includes just the event definitions in a plain text format 
> and a little library with parser to be used by all interested parties.

I'd be fine with that if it's stuck somewhere into tools/lib/ or so.

Thanks,

	Ingo
