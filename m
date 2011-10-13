Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 by ozlabs.org (Postfix) with ESMTP id DC98AB7252
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:53:05 +1100 (EST)
Date: Thu, 13 Oct 2011 17:52:57 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Message-ID: <20111013175257.7e02ddc1@wker>
In-Reply-To: <4E970780.7000100@freescale.com>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
 <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
 <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
 <4E970528.8080908@freescale.com>
 <E8940641-D5F9-4ADE-8892-387BB221AD71@kernel.crashing.org>
 <4E970780.7000100@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 13 Oct 2011 10:45:04 -0500
Timur Tabi <timur@freescale.com> wrote:

> Kumar Gala wrote:
> > I think this 25% number is bogus.  There are cases where it also improves performance.
> 
> I don't think we ever ship a P1022 system with more than 2GB of DDR, so I can't
> see how performance is ever improved.
> 
> I will post a patch that removes the Kconfig option, but I don't understand why
> you couldn't do that when you applied the patch.

please also post a patch providing a working 32bit address
map DTS for this board, then.

Anatolij
