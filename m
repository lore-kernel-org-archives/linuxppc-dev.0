Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (mail.lixom.net [66.141.50.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 42A2DB6F06
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 11:10:03 +1000 (EST)
Date: Tue, 29 Jun 2010 20:10:00 -0500
From: Olof Johansson <olof@lixom.net>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [linuxppc-release] [PATCH] powerpc: introduce basic support
	for the Freescale P1022DS reference board
Message-ID: <20100630011000.GA2684@lixom.net>
References: <1277847274-24648-1-git-send-email-timur@freescale.com>
	<22ED4111-892C-4715-BF70-C1E62F838DDA@kernel.crashing.org>
	<5610599F537DD74A8D1F5CC946A7507303478FF8@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5610599F537DD74A8D1F5CC946A7507303478FF8@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 04:37:59PM -0700, Tabi Timur-B04825 wrote:
> Kumar Gala wrote:
> 
> > Drop the defconfig and update mpc85xx_{smp_}defconfig to build p1022.
> 
> What about video and audio support?  I'm going to add that later?  We don't 
> want to compile the DIU and SSI drivers on all 85xx systems, do we?

Sure, the family-defconfigs are supposed to be supersets that can boot
everywhere. If you're concerned about static kernel size you can always
enable it as modules instead.


-Olof
