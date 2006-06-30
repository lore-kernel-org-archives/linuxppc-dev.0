Return-Path: <LeoLi@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 167CE67B14
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 20:27:38 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	k5UBiaKV000624
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 05:44:36 -0600 (MDT)
Received: from zch01exm40.ap.freescale.net (zch01exm40.ap.freescale.net
	[10.192.130.11])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k5UARYbu013565
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Jun 2006 05:27:35 -0500 (CDT)
Message-ID: <9FCDBA58F226D911B202000BDBAD467306E04FF2@zch01exm40.ap.freescale.net>
From: Li Yang-r58472 <LeoLi@freescale.com>
To: "'Vitaly Bordug'" <vbordug@ru.mvista.com>
Subject: RE: [PATCH 1/7] powerpc: Add mpc8360epb platform support
Date: Fri, 30 Jun 2006 18:27:28 +0800
MIME-Version: 1.0
Content-Type: text/plain
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org, 'Paul Mackerras' <paulus@samba.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Vitaly Bordug [mailto:vbordug@ru.mvista.com]
> Sent: Thursday, June 29, 2006 12:59 AM
> To: Li Yang-r58472
> Cc: 'Paul Mackerras'; linuxppc-dev@ozlabs.org; Phillips Kim-R1AAHA; Chu
> hanjin-r52514; Yin Olivia-r63875; 'linux-kernel@vger.kernel.org'
> Subject: Re: [PATCH 1/7] powerpc: Add mpc8360epb platform support
> 
> On Wed, 28 Jun 2006 22:23:03 +0800
> Li Yang-r58472 <LeoLi@freescale.com> wrote:
> 
[snip]
> 
> >
> >  config MPC834x
> > @@ -24,4 +31,10 @@ config MPC834x
> >  	select PPC_INDIRECT_PCI
> >  	default y if MPC834x_SYS
> >
> > +config MPC836x
> > +	bool
> > +	select PPC_UDBG_16550
> 
> debug option made default?

I'm afraid this is needed to boot.  83xx family platforms need it to initialize early console.  And it does appear in several defconfigs of other platforms.
> > +	select PPC_INDIRECT_PCI
> > +	default y if MPC8360E_PB
> > +
> >  endmenu
