Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id DCCCA67D51
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 16:13:21 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	kAE6YnJp022085
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 23:34:49 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id kAE5DHPC028673
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Nov 2006 23:13:19 -0600 (CST)
Subject: Re: [PATCH 7/32] powerpc: Make pci_read_irq_line the default
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1163479316.5940.96.camel@localhost.localdomain>
References: <20061111062522.34CAC68047@ozlabs.org>
	<1163478030.3472.9.camel@localhost.localdomain>
	<1163479316.5940.96.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1163481241.3748.0.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 14 Nov 2006 13:14:01 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-11-14 at 12:41, Benjamin Herrenschmidt wrote:
> > Paul
> >       I checked your updated git tree just now.
> >       I have seen that you applied Ben's patch on mpc7448hpc2
> platform about
> > the "pci_read_irq_line".
> >       Could you discard this part in Ben's patch and apply mine:
> > 
> > http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027295.html
> > http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027340.html
> >       
> >       Ben must forget this part of patch in his new serial patches.
> >       Thanks.
> 
> Can you instead send a patch that change my code into yours ?
> 
OK, I will provide it soon.
Roy
