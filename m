Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 by ozlabs.org (Postfix) with ESMTP id F0F12B71C5
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Oct 2011 02:50:40 +1100 (EST)
Date: Thu, 13 Oct 2011 17:50:26 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: fix PHYS_64BIT selection for P1022DS
Message-ID: <20111013175026.1479c674@wker>
In-Reply-To: <4E970528.8080908@freescale.com>
References: <1316806370-21067-1-git-send-email-agust@denx.de>
 <6EFB6D12-7505-4D3E-8FF9-033EF74FFB81@kernel.crashing.org>
 <CAOZdJXUWiatadSCmCAvMRrVjVKCJb0xo+XGsF=Rz5-Smp08tMA@mail.gmail.com>
 <6F5815DD-DBF0-4155-94CE-FEDC2C9802E1@kernel.crashing.org>
 <4E970528.8080908@freescale.com>
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

On Thu, 13 Oct 2011 10:35:04 -0500
Timur Tabi <timur@freescale.com> wrote:

> Kumar Gala wrote:
> >> > Why did you apply this patch?  Both Scott and I rejected it.
> 
> > Because its fixing a real issue.  If we want to remove PHYS_64BIT support or make it optional for the board feel free to send another patch.
> 
> Ok, so if someone posts a patch that works but does things the wrong way, and
> that patch gets rejected during reviews, but the submitter doesn't post a
> follow-up patch that does things the right way, you're going to apply the first
> patch anyway?

there is no 32bit address map DTS file for P1022DS in the mainline
tree. A proper patch should then also add appropriate 32bit address
map DTS file. I'm not in the position to do it currently since it would
require testing, I do not have this board to test patches for it.

Anatolij
