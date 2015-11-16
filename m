Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x233.google.com (mail-pa0-x233.google.com
 [IPv6:2607:f8b0:400e:c03::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 78D231A0D69
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 19:02:07 +1100 (AEDT)
Received: by padhx2 with SMTP id hx2so167507793pad.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Nov 2015 00:02:05 -0800 (PST)
Subject: Re: [PATCH v7 12/50] powerpc/powernv: Track M64 segment consumption
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56498D77.2060101@ozlabs.ru>
Date: Mon, 16 Nov 2015 19:01:59 +1100
MIME-Version: 1.0
In-Reply-To: <1446642770-4681-13-git-send-email-gwshan@linux.vnet.ibm.com>
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
> As we track M32 segment consumption, this introduces an array to
> the PHB to track the mapping between M64 segment and PE number.
> The information is going to be used to find M64 segment from the
> PE number during PCI unplugging time in subsequent patches.


It would not hurt to put a few words about how we managed to live without 
such a mapping for M64 before but we needed mapping for M32.




-- 
Alexey
