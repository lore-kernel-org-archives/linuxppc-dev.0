Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B69A7B6F15
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 12:24:43 +1000 (EST)
Date: Tue, 29 Jun 2010 21:24:40 -0500
From: Olof Johansson <olof@lixom.net>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [linuxppc-release] [PATCH] powerpc: introduce basic support for
	the Freescale P1022DS reference board
Message-ID: <20100630022440.GA4942@lixom.net>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<22ED4111-892C-4715-BF70-C1E62F838DDA@kernel.crashing.org>
	<5610599F537DD74A8D1F5CC946A7507303478FF8@az33exm25.fsl.freescale.net>
	<20100630011000.GA2684@lixom.net>
	<5610599F537DD74A8D1F5CC946A7507303478FFA@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5610599F537DD74A8D1F5CC946A7507303478FFA@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 06:16:08PM -0700, Tabi Timur-B04825 wrote:
> Olof Johansson wrote:
> > Sure, the family-defconfigs are supposed to be supersets that can boot
> > everywhere. If you're concerned about static kernel size you can always
> > enable it as modules instead.
> 
> It just seems wrong to add full support for audio and video in the kernel, 
> when it can be used only on one, relatively obscure chip.  Video support 
> would need to be in-kernel only in order to get the console working, and I 
> suspect that core ALSA support would need to be in-kernel as well.

See the text you quoted from me above, it applies at a reply to this as well.


-Olof
