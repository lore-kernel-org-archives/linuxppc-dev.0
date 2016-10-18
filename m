Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3symLL326NzDt2C
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 18:05:30 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id r16so14349533pfg.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2016 00:05:30 -0700 (PDT)
Subject: Re: [PATCH] powerpc: ignore the pkey system calls for now
To: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <20161018093344.1f52d1f9@canb.auug.org.au>
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <91a20b22-10d9-30d4-e259-03c4f5d6fd61@gmail.com>
Date: Tue, 18 Oct 2016 18:05:24 +1100
MIME-Version: 1.0
In-Reply-To: <20161018093344.1f52d1f9@canb.auug.org.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 18/10/16 09:33, Stephen Rothwell wrote:
> Eliminates warning messages:
> 
> <stdin>:1316:2: warning: #warning syscall pkey_mprotect not implemented [-Wcpp]
> <stdin>:1319:2: warning: #warning syscall pkey_alloc not implemented [-Wcpp]
> <stdin>:1322:2: warning: #warning syscall pkey_free not implemented [-Wcpp]
> 
> Hopefully we will remember to revert this commit if we ever implement
> them.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

That makes sense for now

Acked-by: Balbir Singh <bsingharora@gmail.com>
