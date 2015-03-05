Return-Path: <htejun@gmail.com>
Received: from mail-qg0-x236.google.com (mail-qg0-x236.google.com
 [IPv6:2607:f8b0:400d:c04::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C9FD1A0015
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Mar 2015 10:24:32 +1100 (AEDT)
Received: by qgdz107 with SMTP id z107so8855400qgd.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Mar 2015 15:24:29 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date: Thu, 5 Mar 2015 18:24:26 -0500
From: Tejun Heo <tj@kernel.org>
To: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH] powerpc/numa: reset node_possible_map to only
 node_online_map
Message-ID: <20150305232426.GI23912@htj.duckdns.org>
References: <20150305180549.GA29601@linux.vnet.ibm.com>
 <alpine.DEB.2.10.1503051315270.25235@chino.kir.corp.google.com>
 <1425592132.13327.0.camel@ellerman.id.au>
 <alpine.DEB.2.10.1503051352540.25375@chino.kir.corp.google.com>
 <20150305220804.GF23912@htj.duckdns.org>
 <20150305232135.GE30570@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150305232135.GE30570@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 David Rientjes <rientjes@google.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 05, 2015 at 03:21:35PM -0800, Nishanth Aravamudan wrote:
> So, do you agree with the general direction of my change? :)

Yeah, I mean it's an obvious bug fix.  I don't know when or how it
should be set on powerpc but if the machine can't do NUMA node
hotplug, its node online and possible masks must be equal.

Thanks.

-- 
tejun
