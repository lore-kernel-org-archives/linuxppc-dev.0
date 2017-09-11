Return-Path: <sergey.senozhatsky.work@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xr8Rh3KGPzDrb9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Sep 2017 10:48:16 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id q76so4232805pfq.5
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 10 Sep 2017 17:48:16 -0700 (PDT)
Date: Mon, 11 Sep 2017 09:45:23 +0900
From: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 paulmck@linux.vnet.ibm.com, peterz@infradead.org,
 akpm@linux-foundation.org, kirill@shutemov.name, ak@linux.intel.com,
 mhocko@kernel.org, dave@stgolabs.net, jack@suse.cz,
 Matthew Wilcox <willy@infradead.org>, benh@kernel.crashing.org,
 mpe@ellerman.id.au, paulus@samba.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, hpa@zytor.com,
 Will Deacon <will.deacon@arm.com>, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, haren@linux.vnet.ibm.com,
 khandual@linux.vnet.ibm.com, npiggin@gmail.com,
 bsingharora@gmail.com, Tim Chen <tim.c.chen@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, x86@kernel.org
Subject: Re: [PATCH v2 00/20] Speculative page faults
Message-ID: <20170911004523.GA2938@jagdpanzerIV.localdomain>
References: <1503007519-26777-1-git-send-email-ldufour@linux.vnet.ibm.com>
 <20170821022629.GA541@jagdpanzerIV.localdomain>
 <6302a906-221d-c977-4aea-67202eb3d96d@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6302a906-221d-c977-4aea-67202eb3d96d@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On (09/08/17 11:24), Laurent Dufour wrote:
> Hi Sergey,
> 
> I can't see where such a chain could happen.
> 
> I tried to recreate it on top of the latest mm tree, to latest stack output
> but I can't get it.
> How did you raised this one ?

Hi Laurent,

didn't do anything special, the box even wasn't under severe memory
pressure. can re-test your new patch set.

	-ss
