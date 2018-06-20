Return-Path: <dave.hansen@intel.com>
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 419pTt5gHgzF0wM
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jun 2018 01:22:09 +1000 (AEST)
Subject: Re: [PATCH v13 24/24] selftests/vm: test correct behavior of pkey-0
To: Ram Pai <linuxram@us.ibm.com>, shuahkh@osg.samsung.com,
 linux-kselftest@vger.kernel.org
References: <1528937115-10132-1-git-send-email-linuxram@us.ibm.com>
 <1528937115-10132-25-git-send-email-linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 x86@kernel.org, linux-arch@vger.kernel.org, mingo@redhat.com,
 mhocko@kernel.org, bauerman@linux.vnet.ibm.com, fweimer@redhat.com,
 msuchanek@suse.de, aneesh.kumar@linux.vnet.ibm.com
From: Dave Hansen <dave.hansen@intel.com>
Message-ID: <0a7c79a9-8d2d-09cb-30c6-f0f7bca526db@intel.com>
Date: Wed, 20 Jun 2018 08:22:05 -0700
MIME-Version: 1.0
In-Reply-To: <1528937115-10132-25-git-send-email-linuxram@us.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/13/2018 05:45 PM, Ram Pai wrote:
> Ensure pkey-0 is allocated on start.  Ensure pkey-0 can be attached
> dynamically in various modes, without failures.  Ensure pkey-0 can be
> freed and allocated.

I like this.  Looks very useful.

Acked-by: Dave Hansen <dave.hansen@intel.com>
