Return-Path: <ak@linux.intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by lists.ozlabs.org (Postfix) with ESMTP id 947D51A003C
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 May 2015 07:28:46 +1000 (AEST)
Date: Fri, 22 May 2015 14:28:44 -0700
From: Andi Kleen <ak@linux.intel.com>
To: Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc: Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org,
 Arnaldo Carvalho de Melo <acme@kernel.org>, mingo@redhat.com,
 Paul Mackerras <paulus@samba.org>, namhyung@kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/4] perf: jevents: Program to convert JSON file to C
 style file
Message-ID: <20150522212844.GJ7484@tassilo.jf.intel.com>
References: <1432080130-6678-1-git-send-email-sukadev@linux.vnet.ibm.com>
 <1432080130-6678-3-git-send-email-sukadev@linux.vnet.ibm.com>
 <20150522145615.GA16473@krava.redhat.com>
 <20150522155822.GA15904@us.ibm.com>
 <20150522180110.GI7484@tassilo.jf.intel.com>
 <20150522180917.GA5471@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150522180917.GA5471@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Sure, but shouldn't we allow JSON files to be in subdirs
> 
> 	pmu-events/arch/x86/HSX/Haswell_core.json
> 
> and this could go to arbitrary levels?

I used a flat hierarchy. Should be good enough.

-Andi

-- 
ak@linux.intel.com -- Speaking for myself only
