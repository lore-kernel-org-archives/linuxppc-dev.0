Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B873AB7D48
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Jun 2010 17:11:27 +1000 (EST)
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU
	is not set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@linux-m68k.org>
In-Reply-To: <m2wruiy3zg.fsf@igel.home>
References: <1275270628.1931.540.camel@pasglop>
	<1275271231.1931.547.camel@pasglop>
	<FAE73713-EE73-4FA6-B1C6-88D38E230F01@suse.de>
	<m3ljb0tn2l.fsf@hase.home>
	<4C03DB3D.7090007__38063.9078132392$1275321190$gmane$org@suse.de>
	<m2aargndy2.fsf@igel.home>
	<1275384716.1931.711.camel__10281.3212587082$1275384770$gmane$org@pasglop>
	<m3mxvfrt5n.fsf__49359.5060579993$1275385036$gmane$org@hase.home>
	<m2wruiy3zg.fsf@igel.home>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 02 Jun 2010 17:11:06 +1000
Message-ID: <1275462666.1931.767.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > It's crashing in macio_pci_add_devices.
> 
> And snd-aoa is broken, too.

Right, all macio_driver's are. I have a fix, testing now.

Cheers,
Ben.
