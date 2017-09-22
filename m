Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz32x0K0czDsM9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 16:09:12 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id h4so89461pfk.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 23:09:12 -0700 (PDT)
Date: Fri, 22 Sep 2017 16:08:59 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 3/6] mm: display pkey in smaps if arch_pkeys_enabled()
 is true
Message-ID: <20170922160859.33a01da9@firefly.ozlabs.ibm.com>
In-Reply-To: <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
 <1505524870-4783-4-git-send-email-linuxram@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Sep 2017 18:21:07 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> +#ifdef CONFIG_ARCH_HAS_PKEYS
> +	if (arch_pkeys_enabled())

Sorry, I missed this bit in my previous review
the patch makes sense

> +		seq_printf(m, "ProtectionKey:  %8u\n", vma_pkey(vma));
> +#endif
> +

Balbir
