Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EBCA2BDB4
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Oct 2004 13:43:52 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
References: <35fb2e59040930165327f2dd59@mail.gmail.com>
	<87127382-1357-11D9-8EFC-000393DBC2E8@freescale.com>
Content-Type: text/plain
Message-Id: <1096602008.14803.16.camel@gaston>
Mime-Version: 1.0
Date: Fri, 01 Oct 2004 13:40:08 +1000
Cc: jonathan@jonmasters.org, linuxppc-embedded@ozlabs.org
Subject: Re: bi_recs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2004-10-01 at 13:11, Kumar Gala wrote:

> 
> I would be nice to have an extensive and dynamic way to pass info from 
> the bootloader to the kernel.  I believe that Wolfgang has stated he 
> would be willing to change u-boot to match.  I'd be willing to fixup 
> and move Freescale boards over to use something as long as we get 
> u-boot to support it as well.
> 
> I've been told that ARM has a solution, in place, to this problem that 
> might always be worth looking at.

I'd rather see you guys sync with what I did on ppc64 and use that 
kind of OF device-tree, we already have all the code for using it
and it would make the mecanism compatible with the prep/chrp/pmac
kernel...

But that's just a suggestion...

Ben.
