Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.188])
	by ozlabs.org (Postfix) with ESMTP id 1839FDDEE1
	for <linuxppc-dev@ozlabs.org>; Tue, 15 May 2007 16:10:41 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: Small fixes for the Ebony device tree
Date: Tue, 15 May 2007 08:11:09 +0200
References: <20070515020026.GG565@localhost.localdomain>
	<8492e53122b6e1ba269afd53b48a4968@kernel.crashing.org>
	<20070515054758.GC6998@localhost.localdomain>
In-Reply-To: <20070515054758.GC6998@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705150811.09927.sr@denx.de>
Cc: Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 15 May 2007, David Gibson wrote:
> > "ibm,sdram" is way too generic to ever be usefully
> > used for device matching.
>
> Yeah, I guess this should be ibm,sdram-44x or ibm,sdram-4xx.  Better
> go look up if any 40x chips use a similar sdram controller.

Here a list of the current 4xx SDRAM controllers:

SDRAM:		all 40x (except for 405EZ)
DDR:		440GP, 440GX, 440EP, 440GR
DDR2:		440SP, 440SPe
DDR2 (Denali):	440EPx, 440GRx

Best regards,
Stefan
