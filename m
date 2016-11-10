Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDl3t0wWQzDvbQ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 11:56:26 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id 144so1988789pfv.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 16:56:26 -0800 (PST)
Subject: Re: [PATCH v6 4/4] of/fdt: mark hotpluggable memory
To: Reza Arbab <arbab@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Andrew Morton
 <akpm@linux-foundation.org>, Rob Herring <robh+dt@kernel.org>,
 Frank Rowand <frowand.list@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <1478562276-25539-1-git-send-email-arbab@linux.vnet.ibm.com>
 <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 devicetree@vger.kernel.org, Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Alistair Popple <apopple@au1.ibm.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <aea94234-b3d8-1484-d3ab-39e562d7901d@gmail.com>
Date: Thu, 10 Nov 2016 11:56:02 +1100
MIME-Version: 1.0
In-Reply-To: <1478562276-25539-5-git-send-email-arbab@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 08/11/16 10:44, Reza Arbab wrote:
> When movable nodes are enabled, any node containing only hotpluggable
> memory is made movable at boot time.
> 
> On x86, hotpluggable memory is discovered by parsing the ACPI SRAT,
> making corresponding calls to memblock_mark_hotplug().
> 
> If we introduce a dt property to describe memory as hotpluggable,
> configs supporting early fdt may then also do this marking and use
> movable nodes.

This looks much better, like the other comments pointed out

We need documentation around the changes. One quick question

Have you tested this across all combinations of skiboot/kexec/SLOF boots?

Balbir Singh.
