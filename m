Return-Path: <bharata.rao@gmail.com>
Received: from mail-vn0-x22d.google.com (mail-vn0-x22d.google.com
 [IPv6:2607:f8b0:400c:c0f::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDE351A05F3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Jun 2015 14:01:16 +1000 (AEST)
Received: by vnbf129 with SMTP id f129so4572229vnb.4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jun 2015 21:01:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com>
References: <CAGZKiBrmkSa1yyhbf5hwGxubcjsE5SmkSMY4tpANERMe2UG4bg@mail.gmail.com>
Date: Wed, 24 Jun 2015 09:31:12 +0530
Message-ID: <CAGZKiBpWtPKLR+P_gQ8LguS7p4sZt4EvyNqCW_7t8NovGmNpPg@mail.gmail.com>
Subject: Re: powerpc,numa: Memory hotplug to memory-less nodes ?
From: Bharata B Rao <bharata.rao@gmail.com>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@au1.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

So will it be correct to say that memory hotplug to memory-less node
isn't supported by PowerPC kernel ? Should I enforce the same in QEMU
for PowerKVM ?

On Mon, Jun 22, 2015 at 10:18 AM, Bharata B Rao <bharata.rao@gmail.com> wrote:
> Hi,
>
> While developing memory hotplug support in QEMU for PoweKVM, I
> realized that guest kernel has specific checks to prevent hot addition
> of memory to a memory-less node.
>
> I am referring to arch/powerpc/mm/numa.c:hot_add_scn_to_nid() which
> has explicit checks to ensure that it returns a nid that has some some
> memory (NODE_DATA(nid)->node_spanned_pages) even when user wants to
> hotplug to a node that currently has zero memory.
>
> Is this limitation by design ?
>
> Regards,
> Bharata.
> --
> http://raobharata.wordpress.com/



-- 
http://raobharata.wordpress.com/
