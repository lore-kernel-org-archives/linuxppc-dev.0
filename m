Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 19262DDF14
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jan 2008 16:05:13 +1100 (EST)
Subject: Re: add phy-handle property for fec_mpc52xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18309.33088.653225.116715@cargo.ozlabs.ibm.com>
References: <20080109140608.GA15673@aepfle.de> <4784E78C.40904@genesi-usa.com>
	<1199893757.2978.73.camel@pmac.infradead.org>
	<18309.33088.653225.116715@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 10 Jan 2008 16:04:44 +1100
Message-Id: <1199941484.6734.226.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>,
	David Woodhouse <dwmw2@infradead.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thu, 2008-01-10 at 13:21 +1100, Paul Mackerras wrote:
> David Woodhouse writes:
> 
> > It would be much better if the kernel would 'just work'. The ideal way
> > of achieving that is for the firmware to be fixed -- but that's been
> > promised for a long time now, and we just don't believe you any more. So
> > working round it in the kernel seems to be the next best option.
> 
> Does the efika use a boot wrapper?  If so then putting the fixup in
> the boot wrapper might be better.

It's standard OF boot process, the fixup belongs in prom_init. Grant has
a better version of the patch that puts the fixup along with other efika
related ones that are already there.

Cheers,
Ben.
