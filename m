Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tKt470Jw7zDvgw
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Nov 2016 20:29:27 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Liu ping fan <kernelfans@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: fadump: a question about "ibm,configure-kernel-dump"
In-Reply-To: <CAFgQCTsUmYYSwNEJp=YD_FxVvGsW3G_69PdZxuGcF2P6JS-0vQ@mail.gmail.com>
References: <CAFgQCTsUmYYSwNEJp=YD_FxVvGsW3G_69PdZxuGcF2P6JS-0vQ@mail.gmail.com>
Date: Fri, 18 Nov 2016 20:29:23 +1100
Message-ID: <87vavlgmq4.fsf@concordia.ellerman.id.au>
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

Liu ping fan <kernelfans@gmail.com> writes:

> I have an ibm-p8-garrison machine. But I can not find a node
> "ibm,configure-kernel-dump" under /proc/device-tree.  Does garrison
> machine support fadump? And normally, which component in open-power
> presents the "ibm,configure-kernel-dump" ?  I had though it was in
> skiboot gitree or  garrison-xml gitree, but found nothing.

fadump only exists for guests running under PowerVM (LPARs). It sounds
like you're running bare metal (because you mention skiboot).

If you're talking about guests on top of KVM then it *could* be
implemented, but AFAIK Qemu/KVM do not implement it.

cheers
