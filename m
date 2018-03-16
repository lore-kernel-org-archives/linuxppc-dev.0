Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 402nPb12fjzDqZ5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2018 01:08:51 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe LEROY <christophe.leroy@c-s.fr>,
 Mathieu Malaterre <malat@debian.org>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Jiri Slaby <jslaby@suse.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 04/21] powerpc: Mark both tmp variables as unused
In-Reply-To: <3f881ec2-eb0f-77e6-f1c5-95530b8f84ad@c-s.fr>
References: <20180225172236.29650-1-malat@debian.org>
 <20180225172236.29650-5-malat@debian.org>
 <3f881ec2-eb0f-77e6-f1c5-95530b8f84ad@c-s.fr>
Date: Sat, 17 Mar 2018 01:08:49 +1100
Message-ID: <87tvtgglji.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe LEROY <christophe.leroy@c-s.fr> writes:

> Le 25/02/2018 =C3=A0 18:22, Mathieu Malaterre a =C3=A9crit=C2=A0:
>> Since the value of `tmp` is never intended to be read, declare both `tmp`
>> variables as unused. Fix warning (treated as error in W=3D1):
>
> What about using fault_in_pages_readable() instead ?

Yeah that looks like it would work.

I'd be happy to take a tested patch :D

cheers
