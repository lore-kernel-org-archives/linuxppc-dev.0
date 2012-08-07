Return-Path: <B04825@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3D1A32C0098
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2012 12:20:16 +1000 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tiejun Chen <tiejun.chen@windriver.com>
Subject: Re: [v2 PATCH 1/1] booke/wdt: some ioctls do not return values
 properly
Date: Tue, 7 Aug 2012 02:20:10 +0000
Message-ID: <CAOZdJXXViXtto5mFQwPxK7Z5DnTMRYxeViQvW4xmvgn-fapZHg@mail.gmail.com>
References: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
In-Reply-To: <1344304780-13555-1-git-send-email-tiejun.chen@windriver.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 6, 2012 at 8:59 PM, Tiejun Chen <tiejun.chen@windriver.com> wro=
te:
> Fix some booke wdt ioctls return value error.
>
> Signed-off-by: Tiejun Chen <tiejun.chen@windriver.com>

It's not the greatest patch description, but it'll do.

Acked-by: Timur Tabi <timur@freescale.com>

--=20
Timur Tabi
Linux kernel developer at Freescale=
