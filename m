Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v2gfb1LpCzDqbx
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2017 17:48:23 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id f144so15583856pfa.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Jan 2017 22:48:23 -0800 (PST)
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 17 Jan 2017 12:18:14 +0530
To: Reza Arbab <arbab@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>, Alistair Popple <apopple@au1.ibm.com>
Subject: Re: [PATCH v5 2/4] powerpc/mm: add radix__create_section_mapping()
Message-ID: <20170117064814.GC8963@dhcp-9-109-223-248.in.ibm.com>
References: <1484593666-8001-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1484593666-8001-3-git-send-email-arbab@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1484593666-8001-3-git-send-email-arbab@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 16, 2017 at 01:07:44PM -0600, Reza Arbab wrote:
> Wire up memory hotplug page mapping for radix. Share the mapping
> function already used by radix_init_pgtable().
> 
> Signed-off-by: Reza Arbab <arbab@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>
