Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 7D09D2C036E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jul 2013 22:57:44 +1000 (EST)
Date: Thu, 4 Jul 2013 14:57:00 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH v2 2/2] perf tools: Make Power7 events available for perf
Message-ID: <20130704125700.GM18898@dyad.programming.kicks-ass.net>
References: <1372170933-4538-1-git-send-email-runzhen@linux.vnet.ibm.com>
 <1372170933-4538-3-git-send-email-runzhen@linux.vnet.ibm.com>
 <alpine.DEB.2.02.1306251240440.25443@pianoman.cluster.toy>
 <20130704125218.GA21134@concordia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130704125218.GA21134@concordia>
Cc: vincent.weaver@maine.edu, Vince Weaver <vince@deater.net>,
 Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org,
 acme@redhat.com, paulus@samba.org, xiaoguangrong@linux.vnet.ibm.com,
 Runzhen Wang <runzhen@linux.vnet.ibm.com>, sukadev@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 04, 2013 at 10:52:18PM +1000, Michael Ellerman wrote:
> I don't think it even needs libpfm4, just some csv files in tools/perf
> would do the trick.

Right; I think Stephane and Jiri are in favour of creating a 'new' project that
includes just the event definitions in a plain text format and a little library
with parser to be used by all interested parties.

Its just not something that's moving along at any pace at all atm :/
