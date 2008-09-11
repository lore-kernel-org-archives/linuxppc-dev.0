Return-Path: <rbrito@ime.usp.br>
Received: from hope.ime.usp.br (hope.ime.usp.br [143.107.45.8])
	by ozlabs.org (Postfix) with SMTP id 1691CDDF53
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Sep 2008 16:38:40 +1000 (EST)
Date: Thu, 11 Sep 2008 02:34:27 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Marc Zyngier <maz@misterjones.org>
Subject: Re: Call Trace and scary messages on kernel 2.6.27-rc5
Message-ID: <20080911053427.GC5476@ime.usp.br>
References: <20080909004727.GA6239@ime.usp.br> <20080909220855.658b967c@why>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20080909220855.658b967c@why>
Cc: linuxppc-dev@ozlabs.org, debian-powerpc@lists.debian.org,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks to both Mark and Heiko.

On Sep 09 2008, Marc Zyngier wrote:
> On Mon, 8 Sep 2008 21:47:29 -0300 Rogério Brito <rbrito@ime.usp.br> wrote:
> > I just compiled a new 2.6.27-rc5 kernel for my standard Kurobox (an
> > embedded NAS that has an MPC8241 CPU, if I'm not mistaken) and upon
> > booting, I get these scary messages and Call Traces:
> 
> This is a known problem.
> 
> Check patch bb23b431db7405f6d79f989ad0236bf6428ba1cb in Linus' tree, it
> should correct the traces you see.

I just downloaded the 2.6.27-rc6 kernel that was updated today and I
recompiled things and everything went fine regarding the MTD device.

Thank you very much for the informative messages.


Regards, Rogério Brito.

-- 
Rogério Brito : rbrito@{mackenzie,ime.usp}.br : GPG key 1024D/7C2CAEB8
http://www.ime.usp.br/~rbrito : http://meusite.mackenzie.com.br/rbrito
Projects: algorithms.berlios.de : lame.sf.net : vrms.alioth.debian.org
