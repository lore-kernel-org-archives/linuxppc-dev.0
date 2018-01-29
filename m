Return-Path: <dan.j.williams@intel.com>
Received: from mail-ot0-x229.google.com (mail-ot0-x229.google.com
 [IPv6:2607:f8b0:4003:c0f::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVl8C2rZXzF0Pn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 09:49:55 +1100 (AEDT)
Received: by mail-ot0-x229.google.com with SMTP id r4so8134455oti.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 14:49:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180129170445.0e3cc514@canb.auug.org.au>
References: <20180129170445.0e3cc514@canb.auug.org.au>
From: Dan Williams <dan.j.williams@intel.com>
Date: Mon, 29 Jan 2018 14:49:52 -0800
Message-ID: <CAPcyv4g2pfoe8bpVaKDyrVKJZwSN=+J4U=SvKrsa_mLyT_7pfg@mail.gmail.com>
Subject: Re: linux-next: manual merge of the nvdimm tree with the powerpc tree
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jan 28, 2018 at 10:04 PM, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Dan,
>
> Today's linux-next merge of the nvdimm tree got a conflict in:
>
>   arch/powerpc/sysdev/axonram.c
>
> between commit:
>
>   1d65b1c886be ("powerpc/cell: Remove axonram driver")
>
> from the powerpc tree and commit:
>
>   785a3fab4adb ("mm, dax: introduce pfn_t_special()")
>
> from the nvdimm tree.
>
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any
> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.

Thanks Stephen, resolution looks good to me.
