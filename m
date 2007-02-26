Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-02.arcor-online.net (mail-in-02.arcor-online.net
	[151.189.21.42])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B540FDDDEC
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Feb 2007 10:33:15 +1100 (EST)
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302AA0181@az33exm25.fsl.freescale.net>
References: <9696D7A991D0824DBA8DFAC74A9C5FA302AA0181@az33exm25.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <213956050aa89759f6329f518e46f42b@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: #cpus property
Date: Tue, 27 Feb 2007 00:33:05 +0100
To: "Yoder Stuart-B08248" <stuart.yoder@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Anyone know the origin of the #cpus property that seems to be in most 
> of
> the DTS files.  It seems to be documented nowhere.

It was there in the first DTS file to hit the kernel
source tree.  Probably all others just copied that.

> It's obviously describing how many cpus exist.  However, greping the
> kernel source turns up no references to it.
>
> Is it supposed to be required for all cpus nodes?  Are there plans to
> actually use it?

It is utterly redundant as simply looking at the number
of child nodes of /cpus/ will tell you the same thing.

Well *hopefully* the same thing, heh.


Segher
