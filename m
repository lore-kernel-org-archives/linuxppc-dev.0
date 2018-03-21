Return-Path: <aik@ozlabs.ru>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405dNp6KWQzF1gt
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2018 16:18:02 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id w3-v6so5310456itc.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Mar 2018 22:18:02 -0700 (PDT)
Received: from [10.61.2.175] ([122.99.82.10])
 by smtp.googlemail.com with ESMTPSA id i94sm2096433ioo.46.2018.03.20.22.17.59
 for <linuxppc-dev@lists.ozlabs.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 20 Mar 2018 22:18:00 -0700 (PDT)
Subject: Re: [PATCH v2 3/9] powerpc/eeh: Fix misleading comment in
 __eeh_addr_cache_get_device()
To: linuxppc-dev@lists.ozlabs.org
References: <cover.1521427331.git.sam.bobroff@au1.ibm.com>
 <a08f33ca4af93b1a6ec066b8091953c855d52f45.1521427331.git.sam.bobroff@au1.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <4b09c7c9-7580-9106-b11d-8a1a7c4e1588@ozlabs.ru>
Date: Wed, 21 Mar 2018 16:17:57 +1100
MIME-Version: 1.0
In-Reply-To: <a08f33ca4af93b1a6ec066b8091953c855d52f45.1521427331.git.sam.bobroff@au1.ibm.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 19/3/18 1:46 pm, Sam Bobroff wrote:
> Commit "0ba178888b05 powerpc/eeh: Remove reference to PCI device"
> removed a call to pci_dev_get() from __eeh_addr_cache_get_device() but
> did not update the comment to match.
> 
> Signed-off-by: Sam Bobroff <sam.bobroff@au1.ibm.com>

Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>


> ---
>  arch/powerpc/kernel/eeh_cache.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/eeh_cache.c b/arch/powerpc/kernel/eeh_cache.c
> index d4cc26618809..201943d54a6e 100644
> --- a/arch/powerpc/kernel/eeh_cache.c
> +++ b/arch/powerpc/kernel/eeh_cache.c
> @@ -84,8 +84,7 @@ static inline struct eeh_dev *__eeh_addr_cache_get_device(unsigned long addr)
>   * @addr: mmio (PIO) phys address or i/o port number
>   *
>   * Given an mmio phys address, or a port number, find a pci device
> - * that implements this address.  Be sure to pci_dev_put the device
> - * when finished.  I/O port numbers are assumed to be offset
> + * that implements this address.  I/O port numbers are assumed to be offset
>   * from zero (that is, they do *not* have pci_io_addr added in).
>   * It is safe to call this function within an interrupt.
>   */
> 


-- 
Alexey
