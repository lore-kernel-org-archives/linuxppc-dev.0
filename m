Return-Path: <prasannatsmkumar@gmail.com>
Received: from mail-yw0-x244.google.com (mail-yw0-x244.google.com
 [IPv6:2607:f8b0:4002:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tY6kl1mbszDvk7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2016 03:38:23 +1100 (AEDT)
Received: by mail-yw0-x244.google.com with SMTP id s68so29288461ywg.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 06 Dec 2016 08:38:22 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161206063511.GE3450@naverao1-tp.localdomain>
References: <20161204165521.10045-1-prasannatsmkumar@gmail.com>
 <20161205082357.GB3450@naverao1-tp.localdomain>
 <CANc+2y7OOPGz+Gjgp4A8DcAAJEL1qtStkKfrnhQecVZDCcTSmg@mail.gmail.com>
 <20161206063511.GE3450@naverao1-tp.localdomain>
From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date: Tue, 6 Dec 2016 22:08:19 +0530
Message-ID: <CANc+2y6Giim9OgpnJN_mHFS3Nr4tE0r+HUhS4w2fXMrB9RwSVg@mail.gmail.com>
Subject: Re: [PATCH] PPC: sstep.c: Add modsw, moduw instruction emulation
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, Ananth N <ananth@in.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> I guessed as much, but if you look at the existing function, you'll see
> that things have been arranged in numerical order. As such, it's best to
> stick to that convention.

Makes sense. Will do.
