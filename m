Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tYzMM690NzDw2d
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  8 Dec 2016 13:09:35 +1100 (AEDT)
Received: by mail-pf0-x243.google.com with SMTP id c4so21383928pfb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 07 Dec 2016 18:09:35 -0800 (PST)
Subject: Re: -next build failure with gcc 5.2.1
To: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-next@vger.kernel.org
References: <8BC02969-0A0D-4C59-8E5E-31F5FC2B1391@linux.vnet.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linuxppc-dev@lists.ozlabs.org
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <798a8079-6d96-6a9c-b413-21e46f0fcbb0@gmail.com>
Date: Thu, 8 Dec 2016 13:09:27 +1100
MIME-Version: 1.0
In-Reply-To: <8BC02969-0A0D-4C59-8E5E-31F5FC2B1391@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/07/2016 07:26 PM, Sachin Sant wrote:
> next tree fails to build on a ppc64le box with following message
>
>   LD      init/built-in.o
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: modpost: Found 3 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>   KSYM    .tmp_kallsyms1.o
> kallsyms failure: relative symbol value 0xc000000000000000 out of range in relative mode
> Makefile:969: recipe for target 'vmlinux' failed
> make: *** [vmlinux] Error 1
>
> GCC version is : gcc version 5.2.1 20151010 (Ubuntu 5.2.1-22ubuntu2)
>
> Have attached kernel config file.
>

Thanks, would you be in a position to bisect?

Balbir Singh.
