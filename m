Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C97C52C008C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Feb 2013 11:32:25 +1100 (EST)
Message-ID: <1361406741.4676.44.camel@pasglop>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Wed, 20 Feb 2013 18:32:21 -0600
In-Reply-To: <51253558.1070407@mail.ru>
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-02-20 at 21:43 +0100, Phileas Fogg wrote:

> I found the single commit which brakes kexec stuff for FreeBSD loader or other 
> custom ELF kernels on the PS3 console.
> 
> 
>  From 7230c5644188cd9e3fb380cc97dde00c464a3ba7 Mon Sep 17 00:00:00 2001
> From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Date: Tue, 6 Mar 2012 18:27:59 +1100
> Subject: [PATCH] powerpc: Rework lazy-interrupt handling

Odd... That rework had its own issues and so several patches went in
subsequently to address them. It's possible that the PS3 does more
horrid stuff we missed here but I don't quite see how to relate that to
your specific memory corruption problem...

Do you see any "pattern" to the corruption ? Does it looks like
something known ? IE., exception frame, ASCII data, MSR values, ...

Ben.
