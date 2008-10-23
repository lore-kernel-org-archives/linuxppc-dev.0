Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A61EBDDF09
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 18:36:17 +1100 (EST)
Subject: Re: linux-next: ttydev tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
In-Reply-To: <20081023083406.671d4101@lxorguk.ukuu.org.uk>
References: <20081023172938.0460b191.sfr@canb.auug.org.au>
	<20081023083406.671d4101@lxorguk.ukuu.org.uk>
Content-Type: text/plain
Date: Thu, 23 Oct 2008 18:35:54 +1100
Message-Id: <1224747354.7654.394.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
	ppc-dev <linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-23 at 08:34 +0100, Alan Cox wrote:
> 
> Patch is correct.
> 
> Do the hvc patches have dependancies on the PPC tree as well as the
> tty tree ?

Note that I have a serie of 5 hvc patches in the ppc tree...

Ben.
