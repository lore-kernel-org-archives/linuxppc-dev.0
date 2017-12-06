Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ysFy32NpvzF0GR
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Dec 2017 22:00:11 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Fabio Estevam <festevam@gmail.com>
Cc: paulus@samba.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "robh+dt\@kernel.org" <robh+dt@kernel.org>,
 "linuxppc-dev\@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fabio Estevam <fabio.estevam@nxp.com>
Subject: Re: [PATCH] powerpc/40x: acadia: Fix the 'interrupt-parent' property
In-Reply-To: <CAOMZO5Dh7=NkiXZyug8w8_v9mcYaWyYmkYSdgm9y_f1xOukrTg@mail.gmail.com>
References: <1508245278-5692-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5Ai_S7LpY20pH2LoGuQTrX4ZLevfEhvj+LRrK7DG06oNw@mail.gmail.com>
 <87h8t73xu0.fsf@concordia.ellerman.id.au>
 <CAOMZO5Dh7=NkiXZyug8w8_v9mcYaWyYmkYSdgm9y_f1xOukrTg@mail.gmail.com>
Date: Wed, 06 Dec 2017 22:00:09 +1100
Message-ID: <87o9ncdsue.fsf@concordia.ellerman.id.au>
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

Fabio Estevam <festevam@gmail.com> writes:

> Hi Michael,
>
> On Mon, Dec 4, 2017 at 2:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Will pick it up for 4.16.
>
> Just realized that there is already a fix for this in linux-next:
>
> commit 3d2d4339cc326c427638daa67e264dd455ee1899
> Author: Geert Uytterhoeven <geert+renesas@glider.be>
> Date:   Fri Jun 2 14:38:47 2017 +0200
>
>     powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/
>
>     Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
>     Acked-by: Rob Herring <robh@kernel.org>
>     Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>


Actually it's in mainline - because I merged it!

OK, I was a bit confused for a while there. But it's just that you and
Geert have both sent a fix for the same issue, and I merged his fix.

Sorry for the confusion.

cheers
