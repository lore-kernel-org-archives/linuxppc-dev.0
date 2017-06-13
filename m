Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wn62d1DDHzDqL3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Jun 2017 20:49:13 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Davide Caratti <dcaratti@redhat.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/configs: fix default values for NF_CT_PROTO_*
In-Reply-To: <eb1df478772aec9e4caa43f575df5579c1f4170a.1496668107.git.dcaratti@redhat.com>
References: <eb1df478772aec9e4caa43f575df5579c1f4170a.1496668107.git.dcaratti@redhat.com>
Date: Tue, 13 Jun 2017 20:49:12 +1000
Message-ID: <87lgowgo2f.fsf@concordia.ellerman.id.au>
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

Davide Caratti <dcaratti@redhat.com> writes:

> NF_CT_PROTO_{SCTP,UDPLITE,DCCP} can't be set to 'm' anymore, since they
> have been redefined as 'bool': fix defconfig for linkstation, mvme5100 and
> ppc6xx platforms accordingly.

Since when? ie. which commit changed the symbols to bool from tristate?

cheers
