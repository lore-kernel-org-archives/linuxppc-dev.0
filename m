Return-Path: <dave.hansen@intel.com>
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41W1gw3zX0zF3Hh
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Jul 2018 01:45:32 +1000 (AEST)
Subject: Re: [PATCH v14 10/22] selftests/vm: fix alloc_random_pkey() to make
 it really random
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1531835365-32387-1-git-send-email-linuxram@us.ibm.com>
 <1531835365-32387-11-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <b33e0850-f3ec-86b8-69e8-9e6afb289058@intel.com>
Date: Wed, 18 Jul 2018 08:45:26 -0700
MIME-Version: 1.0
In-Reply-To: <1531835365-32387-11-git-send-email-linuxram@us.ibm.com>
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
> alloc_random_pkey() was allocating the same pkey every time.
> Not all pkeys were geting tested. fixed it.

This fixes a real issue but also unnecessarily munges whitespace.  If
you rev these again, please fix the munging.  Otherwise:

Acked-by: Dave Hansen <dave.hansen@intel.com>
