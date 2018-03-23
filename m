Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x231.google.com (mail-pf0-x231.google.com
 [IPv6:2607:f8b0:400e:c00::231])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 406wJn6rxTzF21c
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 18:34:01 +1100 (AEDT)
Received: by mail-pf0-x231.google.com with SMTP id j20so4417784pfi.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 00:34:01 -0700 (PDT)
Date: Fri, 23 Mar 2018 17:33:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 mauricfo@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] powerpc/mm/radix: Remove unused code
Message-ID: <20180323173346.0d9c144b@roar.ozlabs.ibm.com>
In-Reply-To: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
References: <20180323045627.16800-1-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 23 Mar 2018 10:26:25 +0530
"Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:

> These function are not used in the code. Remove them.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

You already acked this one :)

https://patchwork.ozlabs.org/patch/868852/
