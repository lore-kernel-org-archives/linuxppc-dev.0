Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwzH9112dzDr0c
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Jun 2017 16:12:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: naveen.n.rao@linux.vnet.ibm.com, christophe.leroy@c-s.fr, paulus@samba.org,
 Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v3 3/9] powerpc/kprobes/optprobes: Move over to
 patch_instruction
In-Reply-To: <20170606042945.24997-4-bsingharora@gmail.com>
References: <20170606042945.24997-1-bsingharora@gmail.com>
 <20170606042945.24997-4-bsingharora@gmail.com>
Date: Mon, 26 Jun 2017 16:12:20 +1000
Message-ID: <87k23ze0qj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> With text moving to read-only migrate optprobes to using
> the patch_instruction infrastructure. Without this optprobes
> will fail and complain.
>
> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
> ---
>  arch/powerpc/kernel/optprobes.c | 58 ++++++++++++++++++++++++++---------------
>  1 file changed, 37 insertions(+), 21 deletions(-)

I picked this up too.

cheers
