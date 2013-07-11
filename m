Return-Path: <vincent.weaver@maine.edu>
Received: from mail-ve0-f176.google.com (mail-ve0-f176.google.com
 [209.85.128.176])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id F2E0C2C02CC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Jul 2013 14:36:52 +1000 (EST)
Received: by mail-ve0-f176.google.com with SMTP id c13so6821331vea.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jul 2013 21:36:48 -0700 (PDT)
Date: Thu, 11 Jul 2013 00:42:31 -0400 (EDT)
From: Vince Weaver <vincent.weaver@maine.edu>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
In-Reply-To: <20130710083435.GA24070@gmail.com>
Message-ID: <alpine.DEB.2.10.1307110039560.26051@vincent-weaver-1.um.maine.edu>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
 <20130704125700.GM18898@dyad.programming.kicks-ass.net>
 <20130709012952.GA7185@concordia>
 <alpine.DEB.2.10.1307082204550.26280@vincent-weaver-1.um.maine.edu>
 <20130709081434.GI25631@dyad.programming.kicks-ass.net>
 <20130710030926.GD7491@concordia>
 <20130710083435.GA24070@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: acme@redhat.com, Vince Weaver <vincent.weaver@maine.edu>,
 Peter Zijlstra <peterz@infradead.org>, Vince Weaver <vince@deater.net>,
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

On Wed, 10 Jul 2013, Ingo Molnar wrote:

> Exactly - PMUs enumerated in /sys should be self-identifying, it's a 
> hardware topology after all ...
> 
> Anytime userspace is forced to look into /proc, or into weird places in 
> /sys it's a FAIL really.

well on x86 you have to look at /proc/cpuinfo to get the 
vendor/family/model number.  Should we add some specifier under sys?
It's probably too late though as all userspace event libs will have
to look at /proc/cpuinfo anyway to be backwards compatible.

Vince
