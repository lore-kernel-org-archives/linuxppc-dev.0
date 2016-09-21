Return-Path: <kim.phillips@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 3sfVF74SznzDshZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Sep 2016 05:34:34 +1000 (AEST)
Date: Wed, 21 Sep 2016 14:34:27 -0500
From: Kim Phillips <kim.phillips@arm.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: <linux-kernel@vger.kernel.org>, <acme@kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>, <peterz@infradead.org>,
 <mingo@redhat.com>, <alexander.shishkin@linux.intel.com>,
 <treeze.taeung@gmail.com>, <naveen.n.rao@linux.vnet.ibm.com>,
 <markus@trippelsdorf.de>, <namhyung@kernel.org>, <pawel.moll@arm.com>,
 <chris.ryder@arm.com>, <jolsa@kernel.org>, <mhiramat@kernel.org>
Subject: Re: [PATCH v7 0/6] perf annotate: Cross arch support + few fixes
Message-Id: <20160921143427.8db0abae30690baadc18de01@arm.com>
In-Reply-To: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
References: <1474472876-2706-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 21 Sep 2016 21:17:50 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> Kim, I don't have arm test machine. Can you please help me to test
> this on arm.

This works for me:  hitting return on return instructions yields
"Invalid jump offset", but I'll get that later.

Thanks,

Kim
