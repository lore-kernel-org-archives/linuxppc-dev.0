Return-Path: <linuxram@us.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7CVg6NzDzDq60
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 07:57:47 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6CLrZnQ120832
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 17:57:45 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3nv5vy-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 17:57:45 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <linuxram@us.ibm.com>;
 Wed, 12 Jul 2017 17:57:44 -0400
Date: Wed, 12 Jul 2017 14:57:29 -0700
From: Ram Pai <linuxram@us.ibm.com>
To: Dave Hansen <dave.hansen@intel.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 khandual@linux.vnet.ibm.com, aneesh.kumar@linux.vnet.ibm.com,
 bsingharora@gmail.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
Subject: Re: [RFC v5 36/38] selftest: PowerPC specific test updates to memory
 protection keys
Reply-To: Ram Pai <linuxram@us.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-37-git-send-email-linuxram@us.ibm.com>
 <c0e2eab4-a724-5155-4ae9-03b37e4b9f54@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c0e2eab4-a724-5155-4ae9-03b37e4b9f54@intel.com>
Message-Id: <20170712215729.GC5525@ram.oc3035372033.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jul 11, 2017 at 10:33:09AM -0700, Dave Hansen wrote:
> On 07/05/2017 02:22 PM, Ram Pai wrote:
> > Abstracted out the arch specific code into the header file, and
> > added powerpc specific changes.
> > 
> > a) added 4k-backed hpte, memory allocator, powerpc specific.
> > b) added three test case where the key is associated after the page is
> > 	accessed/allocated/mapped.
> > c) cleaned up the code to make checkpatch.pl happy
> 
> There's a *lot* of churn here.  If it breaks, I'm going to have a heck
> of a time figuring out which hunk broke.  Is there any way to break this
> up into a series of things that we have a chance at bisecting?

Just finished breaking down the changes into 20 gradual increments.
I have pushed it to my github tree at

https://github.com/rampai/memorykeys.git
branch is memkey.v6-rc3

See if it works for you. I am sure I would have broken something on
x86 since I dont have a x86 platform to test.

Let me know, Thanks,
RP
