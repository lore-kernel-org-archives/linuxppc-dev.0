Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE001.bigfish.com (tx2ehsobe001.messaging.microsoft.com
 [65.55.88.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 20E13B6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jan 2012 04:31:36 +1100 (EST)
Message-ID: <4F01E9EF.3010609@freescale.com>
Date: Mon, 2 Jan 2012 11:31:27 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: <dpervushin@gmail.com>
Subject: Re: [PATCH 1/2][v2] Integrated Flash Controller support
References: <1324987753-30318-1-git-send-email-prabhakar@freescale.com>
 <1325079052.12535.22.camel@mrki-medvjed.diimka.lan>
In-Reply-To: <1325079052.12535.22.camel@mrki-medvjed.diimka.lan>
Content-Type: text/plain; charset="UTF-8"
Cc: Liu Shuo <b35362@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/28/2011 07:30 AM, dmitry pervushin wrote:
> If you're using memory-mapped structure, shouldn't it be announced with
> __attribute__(packed) ?

Why?  We know this isn't going to be compiled on some strange ABI where
a struct with nothing but u32 gets padding.  __attribute__((packed))
also tells GCC the struct itself could be unaligned which is not true.

-Scott
