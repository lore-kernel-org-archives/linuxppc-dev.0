Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6ckT3fcPzDqhq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 08:50:57 +1000 (AEST)
Message-ID: <1499808649.2865.31.camel@kernel.crashing.org>
Subject: Re: [RFC v5 00/38] powerpc: Memory Protection Keys
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>, Michal Hocko <mhocko@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 paulus@samba.org, mpe@ellerman.id.au, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Date: Wed, 12 Jul 2017 07:30:49 +1000
In-Reply-To: <20170711193257.GB5525@ram.oc3035372033.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <20170711145246.GA11917@dhcp22.suse.cz>
 <20170711193257.GB5525@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2017-07-11 at 12:32 -0700, Ram Pai wrote:
> Ideally the MMU looks at the PTE for keys, in order to enforce
> protection. This is the case with x86 and is the case with power9 Radix
> page table. Hence the keys have to be programmed into the PTE.

POWER9 radix doesn't currently support keys.

Cheers,
Ben.
