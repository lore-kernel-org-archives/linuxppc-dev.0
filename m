Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 29E2FDDEC4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2007 08:47:17 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Timur Tabi'" <timur@freescale.com>
Subject: RE: ucc_geth DPRAM alloc error, 2.6.22-rc3
Date: Thu, 14 Jun 2007 00:47:13 +0200
Message-ID: <018e01c7ae0c$c9428950$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
In-Reply-To: <467068E1.8060107@freescale.com>
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> Joakim Tjernlund wrote:
> > Trying to bring up a third ethernet i/f(ifconfig eth2 up) on
> > a Freescale 832x CPU gives me this:
> >  ifconfig eth2 up
> >  ucc_geth_startup: Can not allocate DPRAM memory for 
> p_thread_data_tx.
> >  eth2: Cannot configure net device, aborting.
> >  SIOCSIFFLAGS: Cannot allocate memory
> 
> It's possible that there isn't enough MURAM for three QE 
> ethernet interfaces.

Well, it was in 2.6.20 and now it isn't so something is wasting MURAM.

 Jocke
