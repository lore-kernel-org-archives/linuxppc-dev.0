Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f45.google.com (mail-pa0-f45.google.com
 [209.85.220.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C7ED61A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 16:05:49 +1000 (AEST)
Received: by pabyb7 with SMTP id yb7so99057119pab.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Aug 2015 23:05:47 -0700 (PDT)
Subject: Re: [PATCH v6 00/42] powerpc/powernv: PCI hotplug suppport
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C83F34.9040306@ozlabs.ru>
Date: Mon, 10 Aug 2015 16:05:40 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 08/06/2015 02:11 PM, Gavin Shan wrote:
> The series of patches intend to support PCI slot for PowerPC PowerNV platform,
> which is running on top of skiboot firmware. The patchset requires corresponding
> changes from skiboot firmware, which is sent to skiboot@lists.ozlabs.org
> for review. The PCI slots are exposed by skiboot with device node properties,
> and kernel utilizes those properties to populated PCI slots accordingly.


This does not apply on top of any actual trees I have - torvalds/master, 
powerpc/master, powerpc/next.

The problem patches are (at least):
powerpc/powernv: Enable M64 on P7IOC
powerpc/powernv: Release PEs dynamically

What did you base them on (sha1)? It is always worth mentioning.




-- 
Alexey
