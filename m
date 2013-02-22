Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B6F722C02A4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2013 06:52:57 +1100 (EST)
Message-ID: <1361562773.15017.36.camel@pasglop>
Subject: Re: PS3: Strange issue with kexec and FreeBSD loader
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Phileas Fogg <phileas-fogg@mail.ru>
Date: Fri, 22 Feb 2013 13:52:53 -0600
In-Reply-To: <5127D9CE.2090500@mail.ru>
References: <1360365046.495584377@f356.mail.ru> <5123C729.5040607@mail.ru>
 <5123D864.4060503@mail.ru> <51253558.1070407@mail.ru>
 <1361406741.4676.44.camel@pasglop> <512685B7.5080404@mail.ru>
 <1361478942.4676.53.camel@pasglop> <5126955B.9070808@mail.ru>
 <1361490374.4676.58.camel@pasglop> <5127D9CE.2090500@mail.ru>
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

On Fri, 2013-02-22 at 21:49 +0100, Phileas Fogg wrote:
> i wanted to let you know that i tested your advice. And let me say, it's was a 
> damn good advice :) I can boot FreeBSD loader on Linux 3.8 now, no SHA256 
> checksum failures. And no panics with FreeBSD LiveCD anymore too.
> 
> I just inserted hard_irq_disable() after each local_irq_disable() in 
> arch/powerpc/kernel/machine_kexec_64.c

Awesome ! :-)

Care to send a patch with a Signed-off-by: ?

Cheers,
Ben.
