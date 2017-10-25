Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yMRn75gwXzDqmv
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Oct 2017 21:52:59 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Tyrel Datwyler <tyreld@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 nfont@linux.vnet.ibm.com, stable@vger.kernel.org
Subject: Re: [PATCH] powerpc/vio: dispose of virq mapping on vdevice unregister
In-Reply-To: <7f3c0d38-0931-ef23-5024-a454de5f5e06@linux.vnet.ibm.com>
References: <1506644360-8688-1-git-send-email-tyreld@linux.vnet.ibm.com>
 <7f3c0d38-0931-ef23-5024-a454de5f5e06@linux.vnet.ibm.com>
Date: Wed, 25 Oct 2017 12:52:49 +0200
Message-ID: <87wp3jzegu.fsf@concordia.ellerman.id.au>
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

Tyrel Datwyler <tyreld@linux.vnet.ibm.com> writes:

> Ping...
>
> Anybody, see any issues with this patch?

No it looks OK to me.

I'll put it in next. I'm going to drop the stable tag for now, I'd like
it to get some more testing. We can request a backport later.

cheers
