Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yw0-x243.google.com (mail-yw0-x243.google.com
 [IPv6:2607:f8b0:4002:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY6yn3mNMzDvPl
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 03:48:49 +1100 (AEDT)
Received: by mail-yw0-x243.google.com with SMTP id s68so29325673ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 08:48:48 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161206063628.GF3450@naverao1-tp.localdomain>
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
 <20161206063628.GF3450@naverao1-tp.localdomain>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Tue, 6 Dec 2016 22:18:45 +0530
Message-ID: <CANc+2y6hp3-Dw0YJmeGOvgXDZ_Rn9hpyzxrajohsYSnVnGm8OA@mail.gmail.com>
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> By the way, I missed mentioning previously: please use 'powerpc: '
> prefix for the subject, rather than PPC.

I will change it. Wondering how they are different.

>> Add modsw and moduw instruction emulation support to analyse_instr.
>
> And, it will be better if you can briefly describe what these functions
> do for the benefit of others.

Sure. I will add description.
