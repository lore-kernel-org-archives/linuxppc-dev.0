Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline 
In-reply-to: <20070604234917.GB10877@localhost.localdomain> 
References: <25445.1180941825@neuling.org>
	<20070604234917.GB10877@localhost.localdomain>
Date: Tue, 05 Jun 2007 09:56:37 +1000
Message-ID: <2554.1181001397@neuling.org>
Cc: linuxppc-dev@ozlabs.org, horms@verge.net.au, kexec@lists.infradead.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> > If the cmdline changes between boots, we can get misalignment of the
> > bootargs entry, which in turn corrupts our device tree blob and hence
> > kills our kexec boot.  
> > 
> > Specifically, if the cmdline length was >= 8 before and the new cmdline
> > length is < 8, we can get corruption.
> 
> Hrm.  Have you considered using dtc for this conversion, rather than
> this somewhat dubious looking fs2dt?

Numerous times.  

fs2dt needs to be converted to use the device tree library, but that
will take a lot more work than a 5 minute patch.

Mikey
