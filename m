Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BD1C31007D2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2011 09:14:44 +1100 (EST)
Message-ID: <1322000067.14573.12.camel@pasglop>
Subject: Re: curious why mpc85xx/edac/pcie patch series was never picked up
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <chris.friesen@genband.com>
Date: Wed, 23 Nov 2011 09:14:27 +1100
In-Reply-To: <4ECBDE98.8090705@genband.com>
References: <4ECBDE98.8090705@genband.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: b25806@freescale.com, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-11-22 at 11:40 -0600, Chris Friesen wrote:
> We're doing some work with an mpc85xx-based board and someone pointed to 
> a patch adding PCI/PCIE error interrupt edac support that was proposed 
> by Lan Chunhe over a year ago:
> 
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2010-November/086930.html
> 
> For some reason this doesn't appear to have been picked up for mainline, 
> and I'm curious why not--is there something wrong with it?

Kumar ? What's up there ? Is that a miscommunication with the edac folks
or we just lost it between the cracks ?

Cheers,
Ben.
