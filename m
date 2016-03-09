Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3A8BA1A0007
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 11:10:09 +1100 (AEDT)
Message-ID: <1457482205.5360.114.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: luigi burdo <intermediadc@hotmail.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Cc: "matthew@a-eon.com" <matthew@a-eon.com>, Trevor Dickinson
 <contact@a-eon.com>, "chzigotzky@xenosoft.de" <chzigotzky@xenosoft.de>
Date: Tue, 08 Mar 2016 18:10:05 -0600
In-Reply-To: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
References: <DUB117-W18044BE969CC05E69F545CC8BA0@phx.gbl>
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

On Mon, 2016-02-29 at 20:03 +0100, luigi burdo wrote:
> Hi all,
> sorry for this email but i need to ask to  Alexander Graf and Michael
> Ellerman if will be possible have kvm and kvm-pr for the Freescale/Nix P5020
> cpu . 

KVM for e5500 uses hardware hypervisor features.  PR-mode KVM is not
supported.  Nested KVM is not supported.

> We are testing a new desktop machine with this powerpc cpu classes
> and right now we see kvm under qemu is working only on emb side, this
> because the kernel
> set the e5500 cpu as a emb and there is no an option for build the kernel
> with book3s.

p5020 uses an e5500 core which is book3e.  You cannot use a book3s kernel with
it.  Why would you want to?

I don't know what you mean by "working only on emb side".

-Scott
