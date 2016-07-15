Return-Path: <htejun@gmail.com>
Received: from mail-yw0-x22c.google.com (mail-yw0-x22c.google.com
 [IPv6:2607:f8b0:4002:c05::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrWbw47FrzDqFK
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 22:10:20 +1000 (AEST)
Received: by mail-yw0-x22c.google.com with SMTP id v186so38098894ywd.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 05:10:20 -0700 (PDT)
Date: Fri, 15 Jul 2016 08:10:16 -0400
From: Tejun Heo <htejun@gmail.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Abdul Haleem <abdhalee@linux.vnet.ibm.com>,
 Aneesh Kumar <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/2] workqueue:Fix affinity of an unbound worker of a
 node with 1 online CPU
Message-ID: <20160715121016.GH3078@mtj.duckdns.org>
References: <20160614112234.GF30154@twins.programming.kicks-ass.net>
 <20160615101936.GA31671@in.ibm.com>
 <20160615113249.GH30909@twins.programming.kicks-ass.net>
 <20160615125033.GB31671@in.ibm.com>
 <20160615131415.GI30909@twins.programming.kicks-ass.net>
 <20160615160112.GC24102@mtj.duckdns.org>
 <1466079084.19127.2.camel@ellerman.id.au>
 <20160616124548.GE30921@twins.programming.kicks-ass.net>
 <20160616193905.GC3262@mtj.duckdns.org>
 <57887507.911f240a.687de.08c5SMTPIN_ADDED_BROKEN@mx.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <57887507.911f240a.687de.08c5SMTPIN_ADDED_BROKEN@mx.google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 15, 2016 at 03:30:41PM +1000, Michael Ellerman wrote:
> It looks like this still hasn't gone to Linus for 4.7?
> 
> Could it please, it's a pretty nasty regression on our boxes.

Sorry about that.  Just sent out the pull request.

Thanks.

-- 
tejun
