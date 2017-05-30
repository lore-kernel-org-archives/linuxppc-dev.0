Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x236.google.com (mail-pf0-x236.google.com
 [IPv6:2607:f8b0:400e:c00::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcGmw4VDyzDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 11:51:44 +1000 (AEST)
Received: by mail-pf0-x236.google.com with SMTP id 9so57462098pfj.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 18:51:44 -0700 (PDT)
Date: Tue, 30 May 2017 11:51:31 +1000
From: Balbir Singh <bsingharora@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras
 <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood
 <oss@buserror.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 3/7] powerpc/mm: Fix kernel RAM protection after freeing
 unused memory on PPC32
Message-ID: <20170530115131.6ee8340c@firefly.ozlabs.ibm.com>
In-Reply-To: <be424ab11cc4982193a717ae5dff3b6f9126979e.1496070452.git.christophe.leroy@c-s.fr>
References: <cover.1496070452.git.christophe.leroy@c-s.fr>
 <be424ab11cc4982193a717ae5dff3b6f9126979e.1496070452.git.christophe.leroy@c-s.fr>
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

On Mon, 29 May 2017 17:32:00 +0200 (CEST)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> As seen below, allthough the init sections have been freed, the
> associated memory area is still marked as executable in the
> page tables.

Good catch!

Acked-by: Balbir Singh <bsingharora@gmail.com>
