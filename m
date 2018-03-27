Return-Path: <bsingharora@gmail.com>
Received: from mail-ua0-x230.google.com (mail-ua0-x230.google.com
 [IPv6:2607:f8b0:400c:c08::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 409HF12CdmzF1l6
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2018 14:53:56 +1100 (AEDT)
Received: by mail-ua0-x230.google.com with SMTP id i2so4407846uak.8
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Mar 2018 20:53:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1522118214-7040-1-git-send-email-linuxram@us.ibm.com>
References: <1522118214-7040-1-git-send-email-linuxram@us.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 27 Mar 2018 14:53:53 +1100
Message-ID: <CAKTCnzkJvBPgUKtL0jmpMXMxVf3w4RNG8ioLkAvzDmKuFUkUWg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mm: Fix thread_pkey_regs_init()
To: Ram Pai <linuxram@us.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>,
 "Haren Myneni/Beaverton/IBM" <hbabu@us.ibm.com>,
 Michal Hocko <mhocko@kernel.org>,
 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, fweimer@redhat.com,
 msuchanek@suse.com
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 27, 2018 at 1:36 PM, Ram Pai <linuxram@us.ibm.com> wrote:
> thread_pkey_regs_init() initializes the pkey related registers
> instead of initializing the fields in the task structures.  Fortunately
> those key related registers are re-set to zero when the task
> gets scheduled on the cpu. However its good to fix this glaringly
> visible error.
>
> cc: Michael Ellermen <mpe@ellerman.id.au>
> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
> ---

Acked-by: Balbir Singh <bsingharora@gmail.com>

Balbir Singh
