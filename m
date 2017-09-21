Return-Path: <wei.guo.simon@gmail.com>
Received: from mail-io0-x243.google.com (mail-io0-x243.google.com
 [IPv6:2607:f8b0:4001:c06::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xz47g3Pf7zDsM7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Sep 2017 16:58:23 +1000 (AEST)
Received: by mail-io0-x243.google.com with SMTP id j26so575282iod.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 23:58:23 -0700 (PDT)
Date: Thu, 21 Sep 2017 08:54:26 +0800
From: Simon Guo <wei.guo.simon@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Paul Mackerras <paulus@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>,
 "Naveen N.  Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 David Laight <David.Laight@ACULAB.COM>,
 Christophe LEROY <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v2 2/3] powerpc/64: enhance memcmp() with VMX instruction
 for long bytes comparision
Message-ID: <20170921005426.GC3387@simonLocalRHEL7.x64>
References: <1505950480-14830-1-git-send-email-wei.guo.simon@gmail.com>
 <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1505950480-14830-3-git-send-email-wei.guo.simon@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
On Thu, Sep 21, 2017 at 07:34:39AM +0800, wei.guo.simon@gmail.com wrote:
> From: Simon Guo <wei.guo.simon@gmail.com>
> 
> This patch add VMX primitives to do memcmp() in case the compare size
> exceeds 4K bytes.
> 
> Test result with following test program(replace the "^>" with ""):
> ------
I missed the exit_vmx_ops() part and need to rework on v3.

Thanks,
- Simon
