Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 07BF9B704F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Apr 2012 14:11:26 +1000 (EST)
Message-ID: <1335327081.21961.28.camel@pasglop>
Subject: Re: Regression in 32-bit ppc kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Date: Wed, 25 Apr 2012 14:11:21 +1000
In-Reply-To: <4F976352.4060001@lwfinger.net>
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2012-04-24 at 21:37 -0500, Larry Finger wrote:
> >> Somewhere between v3.2 and v3.3, the kernel in my Powerbook G4
> started issuing
> >> the following traceback on bootup:
> >
> > Does it continue working afterward or not at all ?
> >
> > Are you using the old IDE driver or the newer libata based
> pata_macio ?
> 
> Yes, it finishes the boot, and appears to work correctly. If a device
> is 
> missing, I do not know what it is.
> 
> I think I am using the old IDE driver.
> 
Interesting. Does it make a difference if you switch to pata_macio ?

Cheers,
Ben.
