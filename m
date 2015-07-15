Return-Path: <htejun@gmail.com>
Received: from mail-yk0-x232.google.com (mail-yk0-x232.google.com
 [IPv6:2607:f8b0:4002:c07::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B419E1A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Jul 2015 08:48:02 +1000 (AEST)
Received: by ykdu72 with SMTP id u72so49727366ykd.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jul 2015 15:48:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Wed, 15 Jul 2015 18:47:58 -0400
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 David Rientjes <rientjes@google.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/2] powerpc/numa: fix cpu_to_node() usage during boot
Message-ID: <20150715224758.GS15934@mtj.duckdns.org>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150715203516.GI15934@mtj.duckdns.org>
 <20150715224351.GH38815@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150715224351.GH38815@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Wed, Jul 15, 2015 at 03:43:51PM -0700, Nishanth Aravamudan wrote:
> Ok, thank you for clarifying! From a correctness perspective, even if
> the numbers don't match NUMA nodes, should we expect the grouping to be
> split along NUMA topology?

Yeap, the groups get formed according to the node distances.  Nodes
which are not at LOCAL_DISTANCE are always put in different groups.

Thanks.

-- 
tejun
