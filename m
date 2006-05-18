Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A46C967AC5
	for <linuxppc-dev@ozlabs.org>; Fri, 19 May 2006 09:13:35 +1000 (EST)
Date: Thu, 18 May 2006 18:13:06 -0500
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] powerpc: Add of_parse_dma_window()
Message-ID: <20060518231306.GG8220@pb15.lixom.net>
References: <1147933251.463191.267166640873.qpush@pokey>
	<20060518171159.GD8220@pb15.lixom.net>
	<06890505-B9A0-42B9-A713-A035FBCBDD1B@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <06890505-B9A0-42B9-A713-A035FBCBDD1B@kernel.crashing.org>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, May 19, 2006 at 01:11:51AM +0200, Segher Boessenkool wrote:
> > Acked-by: Olof Johansson <olof@lixom.net>
> >
> > (I'm assuming you've booted it on POWER4 LPAR and JS20, I don't
> > have access to either to make sure it doesn't break there. Main worry
> > would be if it lacked ibm,#dma*-properties for some reason.)
> 
> The code seems to be resilient against that.  Haven't tested though.

Well, yes. I should have said: if it lacks the ibm,#dma- and the
normal addr-cells properties aren't the same as we assumed before.


-Olof
