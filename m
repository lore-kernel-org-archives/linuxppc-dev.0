Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0B131A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:37:47 +1100 (AEDT)
Message-ID: <1457483864.5360.128.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: luigi burdo <intermediadc@hotmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, Christian Zigotzky <chzigotzky@xenosoft.de>
Date: Tue, 08 Mar 2016 18:37:44 -0600
In-Reply-To: <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
 ,<1457482205.5360.114.camel@buserror.net>
 <DUB117-W1369999A718E6C0B33E4DC8C8B30@phx.gbl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Subject: Re: Freescale P5020 cpu will be kvm-pr?
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-03-09 at 01:27 +0100, luigi burdo wrote:
> Hi Scott, thanks for the reply,
> about: I don't know what you mean by "working only on emb side".
> thru qemu 2.5 i can use only ppcemb as kvm not ppc64 or ppc 

Oh, you mean the QEMU target... "ppc64" should work.

> Dont have the Kvm-pr is a really unhappy news, it means we will not have the
> opportunity to run 
> for example Mol-kvm on  this machine.

Right.  KVM on book3e does not allow making the CPU look like a different type
of PPC.  It just lets you create virtual instances of the same CPU.

> about:KVM for e5500 uses hardware hypervisor features
> look like hypervisor is disabled because the main Hardware is too young and
> need a better knowledge.

Not sure what you mean here.

-Scott
