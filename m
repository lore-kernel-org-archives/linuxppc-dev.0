Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x244.google.com (mail-oi0-x244.google.com
 [IPv6:2607:f8b0:4003:c06::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yqzkx4pd7zDwP9
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Dec 2017 20:16:09 +1100 (AEDT)
Received: by mail-oi0-x244.google.com with SMTP id r63so11209993oia.6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Dec 2017 01:16:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87h8t73xu0.fsf@concordia.ellerman.id.au>
References: <1508245278-5692-1-git-send-email-fabio.estevam@nxp.com>
 <CAOMZO5Ai_S7LpY20pH2LoGuQTrX4ZLevfEhvj+LRrK7DG06oNw@mail.gmail.com>
 <87h8t73xu0.fsf@concordia.ellerman.id.au>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 4 Dec 2017 07:16:06 -0200
Message-ID: <CAOMZO5Dh7=NkiXZyug8w8_v9mcYaWyYmkYSdgm9y_f1xOukrTg@mail.gmail.com>
Subject: Re: [PATCH] powerpc/40x: acadia: Fix the 'interrupt-parent' property
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: paulus@samba.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

On Mon, Dec 4, 2017 at 2:45 AM, Michael Ellerman <mpe@ellerman.id.au> wrote:

> Will pick it up for 4.16.

Just realized that there is already a fix for this in linux-next:

commit 3d2d4339cc326c427638daa67e264dd455ee1899
Author: Geert Uytterhoeven <geert+renesas@glider.be>
Date:   Fri Jun 2 14:38:47 2017 +0200

    powerpc: dts: acadia: DT fix s/#interrupts-parent/#interrupt-parent/

    Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
    Acked-by: Rob Herring <robh@kernel.org>
    Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
