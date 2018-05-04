Return-Path: <dave.hansen@intel.com>
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40d4vQ368yzDrLj
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 07:31:13 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Ram Pai <linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180504232647.3412f563@naga.suse.cz>
Cc: mpe@ellerman.id.au, Ulrich.Weigand@de.ibm.com, bsingharora@gmail.com,
 benh@kernel.crashing.org, mhocko@kernel.org, Ingo Molnar <mingo@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Andrew Morton <akpm@linux-foundation.org>, aneesh.kumar@linux.vnet.ibm.com,
 bauerman@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 fweimer@redhat.com, paulus@samba.org, hbabu@us.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <edd3d544-9fa8-5a79-4325-818ee5d7dfb0@intel.com>
Date: Fri, 4 May 2018 14:31:10 -0700
MIME-Version: 1.0
In-Reply-To: <20180504232647.3412f563@naga.suse.cz>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/04/2018 02:26 PM, Michal Suchánek wrote:
> If it is not ok to change permissions of pkey 0 is it ok to free it?

It's pretty much never OK to free it on x86 or ppc.  But, we're not
going to put code in to keep userspace from shooting itself in the foot,
at least on x86.
