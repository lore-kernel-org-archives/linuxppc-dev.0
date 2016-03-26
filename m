Return-Path: <bsingharora@gmail.com>
Received: from mail-qk0-x22d.google.com (mail-qk0-x22d.google.com
 [IPv6:2607:f8b0:400d:c09::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXBKM2Xk7zDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 18:15:51 +1100 (AEDT)
Received: by mail-qk0-x22d.google.com with SMTP id s5so51650055qkd.0
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Mar 2016 00:15:51 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1458921821-14960-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1458921821-14960-1-git-send-email-gwshan@linux.vnet.ibm.com>
Date: Sat, 26 Mar 2016 18:15:48 +1100
Message-ID: <CAKTCnzkm2wsvi8KkTOmowQ9a1a2KQPUoAT+rAb-3dYnwHB=gEg@mail.gmail.com>
Subject: Re: [PATCH RFC] powerpc/mm: Support bootmem for PPC64 again
From: Balbir Singh <bsingharora@gmail.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Li Zhang <zhlcindy@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 26, 2016 at 3:03 AM, Gavin Shan <gwshan@linux.vnet.ibm.com> wrote:
> CONFIG_NO_BOOTMEM is enabled on PPC platforms by default. However,
> user might disable that to have bootmem for other purpose. So it's
> resonable to support it.
>

The changelog could use some rewriting. What other purpose would
bootmem would be used for?

> This implements setup_bootmem() which is called by initmem_init()
> to setup bootmem node and its free bitmap. In the meantime, the
> free pages frames tracked by memblock are released to bootmem.
> In theory, we also need similar thing for PPC32 platforms. However,
> I don't have machine for testing. So that would be something later
> when I have hardware to test.
>

Balbir Singh
