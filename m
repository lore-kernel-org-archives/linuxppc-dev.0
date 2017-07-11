Return-Path: <dave.hansen@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6Th02TkXzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 03:33:19 +1000 (AEST)
Subject: Re: [RFC v5 36/38] selftest: PowerPC specific test updates to memory
 protection keys
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-37-git-send-email-linuxram@us.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <c0e2eab4-a724-5155-4ae9-03b37e4b9f54@intel.com>
Date: Tue, 11 Jul 2017 10:33:09 -0700
MIME-Version: 1.0
In-Reply-To: <1499289735-14220-37-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/2017 02:22 PM, Ram Pai wrote:
> Abstracted out the arch specific code into the header file, and
> added powerpc specific changes.
> 
> a) added 4k-backed hpte, memory allocator, powerpc specific.
> b) added three test case where the key is associated after the page is
> 	accessed/allocated/mapped.
> c) cleaned up the code to make checkpatch.pl happy

There's a *lot* of churn here.  If it breaks, I'm going to have a heck
of a time figuring out which hunk broke.  Is there any way to break this
up into a series of things that we have a chance at bisecting?
