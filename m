Return-Path: <dave.hansen@intel.com>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40h1103hK2zF14n
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 May 2018 01:46:11 +1000 (AEST)
Subject: Re: [PATCH v3] powerpc, pkey: make protection key 0 less special
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
 Ram Pai <linuxram@us.ibm.com>
References: <1525461778-26265-1-git-send-email-linuxram@us.ibm.com>
 <20180509174335.0faab9fc@kitsune.suse.cz>
Cc: mpe@ellerman.id.au, fweimer@redhat.com, msuchanek@suse.com,
 Andrew Morton <akpm@linux-foundation.org>, Ulrich.Weigand@de.ibm.com,
 Ingo Molnar <mingo@kernel.org>, mhocko@kernel.org, paulus@samba.org,
 aneesh.kumar@linux.vnet.ibm.com, bauerman@linux.vnet.ibm.com,
 Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <5e7ed7d9-3fbc-7d60-9c69-bdcef6025167@intel.com>
Date: Wed, 9 May 2018 08:46:08 -0700
MIME-Version: 1.0
In-Reply-To: <20180509174335.0faab9fc@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/09/2018 08:43 AM, Michal Suchánek wrote:
> It seems it is somehow assumed this is key 0 but I did not find it
> documented anywhere nor did I notice an interface for determining the
> default key.

Does the manpage not count as documentation?  :)

"pkey 0 is used as the default key"

https://manpages.debian.org/stretch/manpages/pkeys.7.en.html
