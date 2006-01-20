Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8C9E68A00
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jan 2006 10:15:46 +1100 (EST)
Subject: Re: [Alsa-devel] RFC: OSS driver removal, a slightly different
	approach
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20060120190415.GM19398@stusta.de>
References: <20060119174600.GT19398@stusta.de>
	<20060120115443.GA16582@palantir8> <20060120190415.GM19398@stusta.de>
Content-Type: text/plain
Date: Sat, 21 Jan 2006 10:15:31 +1100
Message-Id: <1137798931.12998.56.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-01-20 at 20:04 +0100, Adrian Bunk wrote:
> On Fri, Jan 20, 2006 at 11:54:43AM +0000, Martin Habets wrote:
> 
> > It seems to me we can already get rid of sound/oss/dmasound now.
> > I cannot find anything refering to it anymore, and the ALSA powermac
> > driver is being maintained.
> 
> You are correct that I forgot to add the dmasound drivers to my list, 
> but I don't think we can get rid of all of them since I doubt the ALSA 
> powermac driver was able to drive m68k hardware.
> 
> Can someone from the ppc developers drop me a small note whether 
> SND_POWERMAC completely replaces DMASOUND_PMAC?

It should...

Ben.
