Return-Path: <a13xp0p0v88@gmail.com>
Received: from mail-wg0-x22f.google.com (mail-wg0-x22f.google.com
 [IPv6:2a00:1450:400c:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B5CF02C0095
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 20:43:28 +1000 (EST)
Received: by mail-wg0-f47.google.com with SMTP id e11so1421307wgh.2
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 May 2013 03:43:23 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20130503085944.69ef751e@crub>
References: <1367407689-16252-1-git-send-email-a13xp0p0v88@gmail.com>
 <20130502171452.GP1960@intel.com>
 <CAF0T0X7XBuL7a=8zwqMnLDB04-Tf=qhCLPZ4T29yNdN6mP5S2A@mail.gmail.com>
 <20130503085944.69ef751e@crub>
Date: Fri, 3 May 2013 14:43:23 +0400
Message-ID: <CAF0T0X5cRMvoZKQQUkQHTLjbzz1xi_1pvUiywsKb5BGvyMGvpg@mail.gmail.com>
Subject: Re: [PATCH 1/1] powerpc: mpc512x_dma: add support for data transfers
 between memory and i/o memory
From: Alexander Popov <a13xp0p0v88@gmail.com>
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Vinod Koul <vinod.koul@intel.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, Dan Williams <djbw@fb.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Anatolij,

> Note that there is a patch for .device_prep_slave_sg() operation
> for this driver as part of this series:
> https://patchwork.kernel.org/patch/2368581/
> https://patchwork.kernel.org/patch/2368591/
Thanks, I haven't seen that patch.
It's certainly what my SCLPC device driver needs
(http://patchwork.ozlabs.org/patch/241010/).
I will send the second version of it which uses .device_prep_slave_sg().

> maybe you can reuse and improve it.
> Anatolij
Should I propose my additions at https://patchwork.kernel.org/patch/2368591/ ?

Best regards,
Alexander
