Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id D2443DE149
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 22:25:57 +1000 (EST)
Content-Type: text/plain; charset="iso-8859-1"
Date: Wed, 30 Apr 2008 14:25:56 +0200
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <56DEE2D3217CD946B290399093C8FA7C212E48@PTLIEXC001.nsn-intra.net>
Message-ID: <20080430122556.40830@gmx.net>
MIME-Version: 1.0
References: <56DEE2D3217CD946B290399093C8FA7C212E48@PTLIEXC001.nsn-intra.net>
Subject: Re: FW: SKB corruption on heavy traffic
To: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>, Scott
	Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I think I have the same problem here with all versions of the 2.6.x kernel
series (tested with kernel v2.6.8/14/16/18/25 on a PPC7455 machine with
different PCI network cards by transferring a big file over NFS/SCP). Data
corruption occurs under high load, but I don't get any kernel oops.

regards,

Gerhard

-------- Original-Nachricht --------
> Datum: Wed, 30 Apr 2008 10:07:15 +0100
> Von: "Franca, Jose (NSN - PT/Portugal - MiniMD)" <jose.franca@nsn.com>
> An: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
> Betreff: FW: SKB corruption on heavy traffic

> >From our latest debugs we found that the problem occurs mainly on skbuff
> code. After some variable time kfree or kalloc result in kernel oops.
> 
> -----Original Message-----
> From: Franca, Jose (NSN - PT/Portugal - MiniMD) 
> Sent: quarta-feira, 30 de Abril de 2008 9:44
> To: 'ext Scott Wood'
> Cc: 	
> Subject: RE: SKB corruption on heavy traffic
> 
> Hello!
> 
> 	Thank you for replying!
> 	It't quite dificult to say if the problem exists without our
> changes, since the all software is dependent on this changes so to work
> with the hardware. I can't answer to that right now on that, but I forgot 
> to add one thing: we have ring buffer full problems on our fcc_enet
> driver from time to time. So, I think the problem could be on linux
> configurations (related to hw) because there is a lot of posts on the web 
> related to problems similar to this (none of them has really solved the
> bottom problem). 
> 
> Regards,
> Filipe 
> 
> -----Original Message-----
> From: ext Scott Wood [mailto:scottwood@freescale.com] 
> Sent: terça-feira, 29 de Abril de 2008 20:15
> To: Franca, Jose (NSN - PT/Portugal - MiniMD)
> Cc: linuxppc-dev@ozlabs.org; linuxppc-embedded@ozlabs.org
> Subject: Re: SKB corruption on heavy traffic
> 
> On Tue, Apr 29, 2008 at 07:39:07PM +0100, Franca, Jose (NSN - PT/Portugal
> - MiniMD) wrote:
> > 	We are developing a MPC8247 based telecom board (512MB), using
> > linux 2.4 with some proprietary changes on IP stack and we are facing
> > some problems when we have heavy traffic on our Ethernet interfaces...
> 
> Do you see these problems without the proprietary changes, and with a
> current kernel?
> 
> -Scott


-- 
Psst! Geheimtipp: Online Games kostenlos spielen bei den GMX Free Games! 
http://games.entertainment.gmx.net/de/entertainment/games/free
