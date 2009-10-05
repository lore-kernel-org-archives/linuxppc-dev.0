Return-Path: <hs@denx.de>
Received: from a.relay.invitel.net (a.relay.invitel.net [62.77.203.3])
	by ozlabs.org (Postfix) with ESMTP id E944CB7BC7
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 17:25:24 +1100 (EST)
Received: from mail.invitel.hu (mail.invitel.hu [213.163.59.4])
	by a.relay.invitel.net (Invitel Core SMTP Transmitter) with ESMTP id
	843F711A0CB
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Oct 2009 08:25:22 +0200 (CEST)
Received: from [192.168.1.6] ([82.131.205.183])
	by mail.invitel.hu (Invitel Messaging Server)
	with ESMTPA id <0KR1009MJ369BG10@invitel.hu> for
	linuxppc-dev@ozlabs.org; Mon, 05 Oct 2009 08:25:22 +0200 (CEST)
Date: Mon, 05 Oct 2009 09:06:58 +0200
From: Heiko Schocher <hs@denx.de>
Subject: Re: [PATCH, RFC] powerpc, pci: fix MODPOST warning
In-reply-to: <4ABB69DA.7030306@denx.de>
To: linuxppc-dev@ozlabs.org
Message-id: <4AC99B12.8020005@denx.de>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-15
References: <4ABB69DA.7030306@denx.de>
Reply-To: hs@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

Heiko Schocher wrote:
> making a powerpc target with PCI support, shows the
> following warning:
> 
>   MODPOST vmlinux.o
> WARNING: vmlinux.o(.text+0x10430): Section mismatch in reference from the function pcibios_allocate_bus_resources() to the function .init.text:reparent_resources()
> The function pcibios_allocate_bus_resources() references
> the function __init reparent_resources().
> This is often because pcibios_allocate_bus_resources lacks a __init
> annotation or the annotation of reparent_resources is wrong.
> 
> This patch fix this warning by removing the __init
> annotation before reparent_resources.

No comments? So, is this fix OK, or unusable?

bye
Heiko
-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
