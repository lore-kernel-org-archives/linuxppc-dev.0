Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2hTF3nXwzDqFW
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 18:25:21 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id e4so5341080pfg.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 23:25:21 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Jan 2017 12:55:13 +0530
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 4/4] powerpc/mm: unstub radix__vmemmap_remove_mapping()
Message-ID: <20170117072513.GE8963@dhcp-9-109-223-248.in.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-5-git-send-email-arbab@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484593666-8001-5-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 01:07:46PM -0600, Reza Arbab wrote:
> Use remove_pagetable() and friends for radix vmemmap removal.
> 
> We do not require the special-case handling of vmemmap done in the x86
> versions of these functions. This is because vmemmap_free() has already
> freed the mapped pages, and calls us with an aligned address range.
> 
> So, add a few failsafe WARNs, but otherwise the code to remove physical
> mappings is already sufficient for vmemmap.

I wonder if we really need them?

Balbir Singh.
