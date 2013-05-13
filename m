Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BBCDB2C009E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 May 2013 01:47:34 +1000 (EST)
Date: Mon, 13 May 2013 10:47:17 -0500
From: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 1/4] powerpc/book3e: introduce external_input_edge
 exception handler for 64bit kernel
To: Kevin Hao <haokexin@gmail.com>
In-Reply-To: <1368314784-971-2-git-send-email-haokexin@gmail.com> (from
 haokexin@gmail.com on Sat May 11 18:26:21 2013)
Message-ID: <1368460037.8202.8@snotra>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; delsp=Yes; format=Flowed
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/11/2013 06:26:21 PM, Kevin Hao wrote:
> In the external proxy facility mode, the interrupt is automatically
> acknowledged with the same effect as reading the IACK register. So
> this makes external input interrupt more like edge sensitive. That
> means we can leave the irq hard enabled when it occurs with irq soft
> disabled just like the dec and doorbell interrupt. But the External
> Proxy Register(EPR) is only considered valid from the time that the
> external interrupt occurs until MSR[EE] is set to 1. So we have to
> save the EPR before irq hard enabled.

Is it really worth it?  Are you having a real-world problem with =20
profilability as things stand, that this resolves?  We should already =20
be no worse off than non-external-proxy hardware...

-Scott=
