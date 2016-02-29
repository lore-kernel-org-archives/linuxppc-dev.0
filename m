Return-Path: <alessio.bogani@elettra.eu>
Received: from spamalot.elettra.eu (spamalot.elettra.trieste.it
 [140.105.206.208])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A82141A0013
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 21:34:06 +1100 (AEDT)
Received: from spamalot.elettra.eu (localhost.localdomain [127.0.0.1])
 by localhost (Email Security Appliance) with SMTP id 4F658440EC3_6D41E9AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 10:34:02 +0000 (GMT)
Received: from mail-qg0-f53.google.com (mail-qg0-f53.google.com
 [209.85.192.53])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (verified OK))
 by spamalot.elettra.eu (Sophos Email Appliance) with ESMTPSA id
 04DEB43E04A_6D41E99F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 10:34:01 +0000 (GMT)
Received: by mail-qg0-f53.google.com with SMTP id d32so55795430qgd.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Feb 2016 02:34:00 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
References: <1456397825-1786-1-git-send-email-alessio.bogani@elettra.eu>
 <1456397825-1786-2-git-send-email-alessio.bogani@elettra.eu>
Date: Mon, 29 Feb 2016 11:33:59 +0100
Message-ID: <CAPk1OjFw-wQ+2AGq_oHoWM6F7bvbRuMbL9NVtrDwAhKdf86gzw@mail.gmail.com>
Subject: Re: [RFC PATCH v1 2/2] powerpc/86xx: Introduce and use common dtsi
From: Alessio Igor Bogani <alessio.bogani@elettra.eu>
To: Scott Wood <oss@buserror.net>, Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
 Alessio Igor Bogani <alessio.bogani@elettra.eu>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On 25 February 2016 at 11:57, Alessio Igor Bogani
<alessio.bogani@elettra.eu> wrote:
> Signed-off-by: Alessio Igor Bogani <alessio.bogani@elettra.eu>
> ---
>  arch/powerpc/boot/dts/fsl/gef_ppc9a.dts        | 284 +++-------------------
>  arch/powerpc/boot/dts/fsl/gef_sbc310.dts       | 276 +++------------------
>  arch/powerpc/boot/dts/fsl/gef_sbc610.dts       | 284 +++-------------------
>  arch/powerpc/boot/dts/fsl/mpc8641_hpcn.dts     | 318 ++++---------------------
>  arch/powerpc/boot/dts/fsl/mpc8641_hpcn_36b.dts | 317 ++++--------------------
>  arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi  | 124 ++++++++++
>  arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi   |  59 +++++
>  arch/powerpc/boot/dts/fsl/sbc8641d.dts         | 314 +++---------------------
>  8 files changed, 400 insertions(+), 1576 deletions(-)
>  create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-post.dtsi
>  create mode 100644 arch/powerpc/boot/dts/fsl/mpc8641si-pre.dtsi
[...]

Any comments?

Thanks!

Ciao,
Alessio
