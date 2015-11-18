Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22f.google.com (mail-pa0-x22f.google.com
 [IPv6:2607:f8b0:400e:c03::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC6C91A06B1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Nov 2015 13:43:17 +1100 (AEDT)
Received: by pacej9 with SMTP id ej9so28422648pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 18:43:15 -0800 (PST)
Subject: Re: [PATCH v7 28/50] powerpc/pci: Rename
 pcibios_{add,remove}_pci_devices()
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-29-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <564BE5BA.30907@ozlabs.ru>
Date: Wed, 18 Nov 2015 13:43:06 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-29-git-send-email-gwshan@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/05/2015 12:12 AM, Gavin Shan wrote:
> This renames pcibios_{add,remove}_pci_devices() to avoid conflicts
> with names of the weak functions in PCI subsystem, which have the
> prefix "pcibios". No logical changes introduced.


As you mentioned before, the patchset is organized as "code refactoring,
IO/M32/M64, DMA, PE allocation/releaseing". This patch fits into the 
refactoring category so it goes to the beginning of the series :)


-- 
Alexey
