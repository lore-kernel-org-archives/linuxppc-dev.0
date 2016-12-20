Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tjSXx3kkZzDwNb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2016 17:28:49 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id g1so8975690pgn.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 22:28:49 -0800 (PST)
Subject: Re: [PATCH v3 3/5] powerpc/mm: add radix__create_section_mapping()
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
References: <1481831443-22761-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1481831443-22761-4-git-send-email-arbab@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <42967170-8b23-4682-ea44-4df0b1b205fd@gmail.com>
Date: Tue, 20 Dec 2016 17:28:40 +1100
MIME-Version: 1.0
In-Reply-To: <1481831443-22761-4-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>
> +#ifdef CONFIG_MEMORY_HOTPLUG
> +int radix__create_section_mapping(unsigned long start, unsigned long end)
> +{
> +	unsigned long page_size = 1 << mmu_psize_defs[mmu_linear_psize].shift;

Can we refactor bits from radix_init_pgtable() and reuse?

Balbir
