Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id F228E1A0EC7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 22:09:58 +1000 (AEST)
Date: Tue, 26 May 2015 22:09:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Laurentiu Tudor <b10716@freescale.com>
Cc: <benh@kernel.crashing.org>, <paulus@samba.org>, <mpe@ellerman.id.au>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] powerpc/perf: Fix book3s kernel to userspace backtraces
Message-ID: <20150526220957.4bd69895@kryten>
In-Reply-To: <556433D2.4010102@freescale.com>
References: <1432617024-11352-1-git-send-email-anton@samba.org>
 <556433D2.4010102@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Laurentiu,

> > +	if ((TRAP(regs) == 0xf00) && regs->result)
> > +		return true;
> > +
> > +	return false;
> 
> Why not just
> 
> return (TRAP(regs) == 0xf00) && regs->result;

Could do, it just read a little easier to my tired eyes.

Anton
