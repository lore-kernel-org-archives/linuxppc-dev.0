Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AB5E9B7B61
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Jul 2009 08:33:23 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E13DDDD04
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Jul 2009 08:33:22 +1000 (EST)
Subject: Re: having access to interrupt specifier in map() function
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <761CE7B3-A7FD-41FD-A828-B9F17F73DF32@kernel.crashing.org>
References: <761CE7B3-A7FD-41FD-A828-B9F17F73DF32@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 16 Jul 2009 08:33:17 +1000
Message-Id: <1247697197.27937.2.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2009-07-15 at 09:11 -0500, Kumar Gala wrote:
> Ben,
> 
> Do you have any ideas on keeping access to the interrupt specifier  
> around so when we call map() we have access to it.  Our HV guys are  
> looking at using additional bits in the interrupt specifier to encode  
> information beyond just level/sense of the IRQ and want to make  
> decisions based on it during map().
> 
> Maybe we can keep it around in irq_map[].

Or we could translate those additional info into flags in the IRQ desc ?

Might be possible to request some arch specific flags in there.

Cheers,
Ben.
