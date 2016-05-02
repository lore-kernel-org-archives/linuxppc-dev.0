Return-Path: <bsingharora@gmail.com>
Received: from mail-pa0-x230.google.com (mail-pa0-x230.google.com
 [IPv6:2607:f8b0:400e:c03::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qymMK5rdBzDqBt
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 May 2016 11:05:49 +1000 (AEST)
Received: by mail-pa0-x230.google.com with SMTP id iv1so67530431pac.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 01 May 2016 18:05:49 -0700 (PDT)
Subject: Re: [RFC 1/5] powerpc: Rename context.vdso_base to context.vdso
To: Christopher Covington <cov@codeaurora.org>,
 Catalin Marinas <catalin.marinas@arm.com>, criu@openvz.org,
 Laurent Dufour <ldufour@linux.vnet.ibm.com>,
 Will Deacon <Will.Deacon@arm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Arnd Bergmann <arnd@arndb.de>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org
References: <20151202121918.GA4523@arm.com>
 <1461856737-17071-1-git-send-email-cov@codeaurora.org>
 <1461856737-17071-2-git-send-email-cov@codeaurora.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <5726A7D5.7030305@gmail.com>
Date: Mon, 2 May 2016 11:05:25 +1000
MIME-Version: 1.0
In-Reply-To: <1461856737-17071-2-git-send-email-cov@codeaurora.org>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 29/04/16 01:18, Christopher Covington wrote:
> In order to share remap and unmap support for the VDSO with other
> architectures without duplicating the code, we need a common name and type
> for the address of the VDSO. An informal survey of the architectures
> indicates unsigned long vdso is popular. Change the variable name in
> powerpc from mm->context.vdso_base to simply mm->context.vdso.
> 

Could you please provide additional details on why the remap/unmap operations are required?
This patch does rename, but should it abstract via a function acesss to vmap field using arch_* operations? Not sure

Balbir Singh
