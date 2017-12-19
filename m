Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x22f.google.com (mail-it0-x22f.google.com
 [IPv6:2607:f8b0:4001:c0b::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z17Wy6Zy2zDsSf
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 17:38:22 +1100 (AEDT)
Received: by mail-it0-x22f.google.com with SMTP id r6so1539073itr.3
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Dec 2017 22:38:22 -0800 (PST)
Subject: Re: [PATCH v1 7/7] pseries/setup: Add Initialization of VF Bars
To: Juan Alvarez <jjalvare@linux.vnet.ibm.com>,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: seroyer@linux.vnet.ibm.com, alex.williamson@redhat.com,
 helgaas@kernel.org, ruscur@russell.cc, linux-pci@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, bodong@mellanox.com, eli@mellanox.com,
 saeedm@mellanox.com
References: <20171213153242.98015-1-bryantly@linux.vnet.ibm.com>
 <20171213153242.98015-8-bryantly@linux.vnet.ibm.com>
 <4ea33f2e-d98c-85ef-eedf-2e8ca49aa839@ozlabs.ru>
 <8bdf7127-a3ec-1c75-2593-e39a8bd31e34@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <fd876ee1-4c12-587b-a8a0-56233fea3401@ozlabs.ru>
Date: Tue, 19 Dec 2017 17:38:10 +1100
MIME-Version: 1.0
In-Reply-To: <8bdf7127-a3ec-1c75-2593-e39a8bd31e34@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/12/17 06:29, Juan Alvarez wrote:
> This is PF only path. Yes either we have a root returned otherwise
> will fall back to iomem_resource.

You have removed context from my response, do not do that please.

When will you have root and when you won't? imho it should always be either
one or another.


> 
> On 12/18/17 1:21 AM, Alexey Kardashevskiy wrote:
>> @dev here is a VF, right? I am not familiar with powervn much but from what
>> I see - the devices are sitting on a root bus of their own PHB and they all
>> either have a root returned from pci_find_parent_resource() or none of them
>> has a root and will fall back to &iomem_resource, or both cases are possible?
> 


-- 
Alexey
