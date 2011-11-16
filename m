Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe002.messaging.microsoft.com [216.32.181.182])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id C1DA2B6FA6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2011 14:02:51 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: "Kokoris, Ioannis" <ioannis.kokoris@siemens-enterprise.com>
Subject: Re: [PATCH] P1021: set IReady in QE Microcode Upload
Date: Wed, 16 Nov 2011 03:02:42 +0000
Message-ID: <CAOZdJXXOrSaUgynqu+CL64SnivtOWHBDMcJK9Fh000M_JBK58Q@mail.gmail.com>
References: <026483A88B848047A08C3F03E20822D0267B1F4A55@MCHP058A.global-ad.net>
 <4EBD4FB8.2020406@freescale.com>
 <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
In-Reply-To: <026483A88B848047A08C3F03E20822D0267B1F4BDB@MCHP058A.global-ad.net>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 14, 2011 at 2:55 AM, Kokoris, Ioannis
<ioannis.kokoris@siemens-enterprise.com> wrote:
> Ready register is needed for ROM-less devices such as P1021, MPC859, MPC8=
306 etc.
> For ROM-based devices such as MCP8323 the Ready register does not exist.
> Is there a global definition for conditionally including this code?

I'll have to check.  But this patch can't be applied as-is unless it's
proven safe for all QE-enabled chips.

--=20
Timur Tabi
Linux kernel developer at Freescale=
