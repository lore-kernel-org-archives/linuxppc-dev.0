Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id F0859DE13E
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:20:44 +1000 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Wed, 30 Apr 2008 21:20:42 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <56DEE2D3217CD946B290399093C8FA7C212F55@PTLIEXC001.nsn-intra.net>
Message-ID: <20080430192042.76910@gmx.net>
MIME-Version: 1.0
References: <56DEE2D3217CD946B290399093C8FA7C212F55@PTLIEXC001.nsn-intra.net>
Subject: Re: RE: FW: SKB corruption on heavy traffic
To: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>,
	scottwood@freescale.com
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Wed, 30 Apr 2008 14:03:02 +0100
> Von: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
> An: "ext Gerhard Pircher" <gerhard_pircher@gmx.net>, "Scott Wood" <scottwood@freescale.com>
> CC: linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
> Betreff: RE: FW: SKB corruption on heavy traffic

> Hi!
> 
> 	There was a sugestion to change slab to slub alocation method... I > don't know quite well yet what is necessary to do this, but it seems that
> the current implementation of slub is more commonly available on 2.6
> kernels, not in 2.4 that I use :(...
> 	Any guesses or hints on this?
I'm using SLUB with kernel v2.6.25 and I still get data corruption on high
load. On the other side it is a good idea to enable SLAB debugging, as
Scott suggested. Maybe that sheds some light on this issue (even if most
of the network drivers make use of DMA).

regards,

Gerhard

> 
> Regards!
> Filipe.
> 
> -----Original Message-----
> From: ext Gerhard Pircher [mailto:gerhard_pircher@gmx.net] 
> Sent: quarta-feira, 30 de Abril de 2008 13:26
> To: Franca, Jose (NSN - PT/Portugal - MiniMD); Scott Wood
> Cc: linuxppc-embedded@ozlabs.org; linuxppc-dev@ozlabs.org
> Subject: Re: FW: SKB corruption on heavy traffic
> 
> Hi,
> 
> I think I have the same problem here with all versions of the 2.6.x
> kernel series (tested with kernel v2.6.8/14/16/18/25 on a PPC7455 machine 
> with different PCI network cards by transferring a big file over
> NFS/SCP). Data corruption occurs under high load, but I don't get any
> kernel oops.
> 
> regards,
> 
> Gerhard

-- 
Ist Ihr Browser Vista-kompatibel? Jetzt die neuesten 
Browser-Versionen downloaden: http://www.gmx.net/de/go/browser
