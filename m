Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz37D70HnzDsMC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 16:12:56 +1000 (AEST)
Received: by mail-pg0-x242.google.com with SMTP id j16so117515pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 23:12:56 -0700 (PDT)
Date: Fri, 22 Sep 2017 16:12:43 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Ram Pai <linuxram@us.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-mm@kvack.org, x86@kernel.org, linux-doc@vger.kernel.org,
 arnd@arndb.de, akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com,
 benh@kernel.crashing.org, paulus@samba.org, khandual@linux.vnet.ibm.com,
 aneesh.kumar@linux.vnet.ibm.com, hbabu@us.ibm.com, mhocko@kernel.org,
 bauerman@linux.vnet.ibm.com, ebiederm@xmission.com
Subject: Re: [PATCH 1/6] mm: introduce an additional vma bit for powerpc pkey
Message-ID: <20170922161243.7d03a5b6@firefly.ozlabs.ibm.com>
In-Reply-To: <1505524870-4783-2-git-send-email-linuxram@us.ibm.com>
References: <1505524870-4783-1-git-send-email-linuxram@us.ibm.com>
 <1505524870-4783-2-git-send-email-linuxram@us.ibm.com>
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

On Fri, 15 Sep 2017 18:21:05 -0700
Ram Pai <linuxram@us.ibm.com> wrote:

> Currently only 4bits are allocated in the vma flags to hold 16
> keys. This is sufficient for x86. PowerPC  supports  32  keys,
> which needs 5bits. This patch allocates an  additional bit.
> 
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
