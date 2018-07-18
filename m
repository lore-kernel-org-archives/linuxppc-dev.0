Return-Path: <dave.hansen@intel.com>
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W1Nf4rMQzF3Hb
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 01:32:18 +1000 (AEST)
Subject: Re: [PATCH v14 06/22] selftests/vm: typecast the pkey register
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-7-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <8c468c61-615a-dd0d-2b73-d3218f38e3e4@intel.com>
Date: Wed, 18 Jul 2018 08:32:10 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-7-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/17/2018 06:49 AM, Ram Pai wrote:
> This is in preparation to accomadate a differing size register
> across architectures.

This is pretty fugly, and reading it again, I wonder whether we should
have just made it 64-bit, at least in all the printk's.  Or even

	prink("pk reg: %*llx\n", PKEY_FMT_LEN, pkey_reg);

But, I don't _really_ care in the end.

Acked-by: Dave Hansen <dave.hansen@intel.com>
