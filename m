Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2Bt32VJbzDrYY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 11:12:43 +1100 (AEDT)
Message-ID: <1513810153.2743.25.camel@kernel.crashing.org>
Subject: Re: [PATCH v9 29/51] mm/mprotect, powerpc/mm/pkeys, x86/mm/pkeys:
 Add sysfs interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ram Pai <linuxram@us.ibm.com>
Cc: Dave Hansen <dave.hansen@intel.com>, mpe@ellerman.id.au, mingo@redhat.com,
 akpm@linux-foundation.org, corbet@lwn.net, arnd@arndb.de,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 hbabu@us.ibm.com, mhocko@kernel.org, bauerman@linux.vnet.ibm.com,
 ebiederm@xmission.com
Date: Thu, 21 Dec 2017 09:49:13 +1100
In-Reply-To: <20171220175022.GB5619@ram.oc3035372033.ibm.com>
References: <1509958663-18737-1-git-send-email-linuxram@us.ibm.com>
 <1509958663-18737-30-git-send-email-linuxram@us.ibm.com>
 <bbc5593e-31ec-183a-01a5-1a253dc0c275@intel.com>
 <20171218221850.GD5461@ram.oc3035372033.ibm.com>
 <e7971d03-6ad1-40d5-9b79-f01242db5293@intel.com>
 <1513719296.2743.12.camel@kernel.crashing.org>
 <20171220175022.GB5619@ram.oc3035372033.ibm.com>
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

On Wed, 2017-12-20 at 09:50 -0800, Ram Pai wrote:
> The argument against this patch is --  it should not be baked into
> the ABI as yet, since we do not have clarity on what applications need.
> 
> As it stands today the only way to figure out the information from
> userspace is by probing the kernel through calls to sys_pkey_alloc().
> 
> AT_HWCAP can be used, but that will certainly not be capable of
> providing all the information that userspace might expect.
> 
> Your thoughts?

Well, there's one well known application wanting that whole keys
business, so why not ask them what works for them ?

In the meantime, that shouldn't block the rest of the patches.

Cheers,
Ben.
