Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3F1161A001D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Jan 2016 21:23:51 +1100 (AEDT)
Message-ID: <1453371824.28627.0.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Enable VMX copy on PPC970 (G5)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Marc Dietrich <marvin24@gmx.de>, linuxppc-dev@lists.ozlabs.org
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
Date: Thu, 21 Jan 2016 21:23:44 +1100
In-Reply-To: <7901441.McfCmZyUcA@fb07-iapwap2>
References: <1453335927-17419-1-git-send-email-mpe@ellerman.id.au>
 <7901441.McfCmZyUcA@fb07-iapwap2>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-01-21 at 10:51 +0100, Marc Dietrich wrote:

> Am Donnerstag, 21. Januar 2016, 11:25:27 schrieb Michael Ellerman:

> > There's no reason I'm aware of that the VMX copy loop shouldn't work on
> > PPC970. And in fact it seems to boot and generally be happy.
> 
> does the same also hold for Cell? Maybe there are even more optimizations 
> which can be copied from PPC970.

Yeah in theory the PPE has VMX, I'll try it.

cheers
