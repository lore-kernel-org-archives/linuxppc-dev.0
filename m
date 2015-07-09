Return-Path: <rientjes@google.com>
Received: from mail-ig0-x231.google.com (mail-ig0-x231.google.com
 [IPv6:2607:f8b0:4001:c05::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A4FF1A0DCB
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jul 2015 11:25:20 +1000 (AEST)
Received: by igcqs7 with SMTP id qs7so69470587igc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2015 18:25:18 -0700 (PDT)
Date: Wed, 8 Jul 2015 18:25:16 -0700 (PDT)
From: David Rientjes <rientjes@google.com>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 Peter Zijlstra <peterz@infradead.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] powerpc/smp: use early_cpu_to_node() instead of
 direct references to numa_cpu_lookup_table
In-Reply-To: <20150702230332.GB2807@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.10.1507081825010.16585@chino.kir.corp.google.com>
References: <20150702230202.GA2807@linux.vnet.ibm.com>
 <20150702230332.GB2807@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2 Jul 2015, Nishanth Aravamudan wrote:

> A simple move to a wrapper function to numa_cpu_lookup_table, now that
> power has the early_cpu_to_node() API.
> 
> Signed-off-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>

When early_cpu_to_node() is __init:

	Acked-by: David Rientjes <rientjes@google.com>
