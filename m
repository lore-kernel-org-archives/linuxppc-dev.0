Return-Path: <robherring2@gmail.com>
Received: from mail-ob0-x235.google.com (mail-ob0-x235.google.com
 [IPv6:2607:f8b0:4003:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B724B2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Nov 2013 09:24:48 +1100 (EST)
Received: by mail-ob0-f181.google.com with SMTP id wp4so5191190obc.12
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Nov 2013 15:24:44 -0700 (PDT)
Message-ID: <52742A2A.9080008@gmail.com>
Date: Fri, 01 Nov 2013 17:24:42 -0500
From: Rob Herring <robherring2@gmail.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the dt-rh tree with the powerpc tree
References: <20131101162002.4dd386299ec42e8d8d032be2@canb.auug.org.au>
In-Reply-To: <20131101162002.4dd386299ec42e8d8d032be2@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>,
 linux-next@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 11/01/2013 12:20 AM, Stephen Rothwell wrote:
> Hi Rob,
> 
> Today's linux-next merge of the dt-rh tree got a conflict in 
> arch/powerpc/include/asm/prom.h between commit a3e31b458844 ("of:
> Move definition of of_find_next_cache_node into common code") from
> the powerpc tree and commit 0c3f061c195c ("of: implement
> of_node_to_nid as a weak function") from the dt-rh tree.

Ben, I can pick these 2 patches up instead if you want to drop them
and avoid the conflict.

Rob
