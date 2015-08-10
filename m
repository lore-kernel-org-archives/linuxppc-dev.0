Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9AA681A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 00:21:26 +1000 (AEST)
Received: by pawu10 with SMTP id u10so141547378paw.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Aug 2015 07:21:25 -0700 (PDT)
Subject: Re: [PATCH v6 17/42] powerpc/powernv: Rename PE# fields in PHB
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-18-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com, panto@antoniou-consulting.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <55C8B35C.4040501@ozlabs.ru>
Date: Tue, 11 Aug 2015 00:21:16 +1000
MIME-Version: 1.0
In-Reply-To: <1438834307-26960-18-git-send-email-gwshan@linux.vnet.ibm.com>
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
> This renames the fields related to PE# in "struct pnv_phb" for
> better reflecting of their usages as Alexey suggested. It doesn't
> introduce behavioural changes.
>
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>


Makes sense to move this to the beginning of the patchset as patches prior 
this are changing the same lines as this patch changes.


-- 
Alexey
