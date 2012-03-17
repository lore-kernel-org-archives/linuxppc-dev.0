Return-Path: <B04825@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe003.messaging.microsoft.com [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0210FB6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 18 Mar 2012 02:47:58 +1100 (EST)
Received: from mail27-am1 (localhost [127.0.0.1])	by mail27-am1-R.bigfish.com
 (Postfix) with ESMTP id E3461260675	for
 <linuxppc-dev@lists.ozlabs.org>; Sat,
 17 Mar 2012 15:47:50 +0000 (UTC)
Received: from AM1EHSMHS020.bigfish.com (unknown [10.3.201.246])	by
 mail27-am1.bigfish.com (Postfix) with ESMTP id EDC091E0046	for
 <linuxppc-dev@lists.ozlabs.org>; Sat, 17 Mar 2012 15:47:48 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Leekha Shaveta-B20052 <B20052@freescale.com>
Subject: Re: [PATCH] mpc85xx_defconfig:Added I2C_CHARDEV option in defconfig
 to have compiled I2C device interface
Date: Sat, 17 Mar 2012 15:47:47 +0000
Message-ID: <CAOZdJXWBG83VhMqaumo9KH43MKjjgo=hdnT0LTgrbMjJy4ALTg@mail.gmail.com>
References: <1331974801-15845-1-git-send-email-shaveta@freescale.com>
In-Reply-To: <1331974801-15845-1-git-send-email-shaveta@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 17, 2012 at 4:00 AM, Shaveta Leekha <shaveta@freescale.com> wro=
te:
> Signed-off-by: Shaveta Leekha <shaveta@freescale.com>
> ---

Where's the patch description?  You need to explain WHY this change is
a good idea.

And you should change all defconfigs in one patch.

--=20
Timur Tabi
Linux kernel developer at Freescale=
