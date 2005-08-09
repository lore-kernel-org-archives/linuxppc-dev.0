Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 6DB2567FD7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 02:26:52 +1000 (EST)
Date: Tue, 9 Aug 2005 09:26:49 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050809162649.GA22053@gate.ebshome.net>
References: <42F89F49.4000205@softadvances.com>
	<A9E0A66D-CE6F-4A55-80FD-5D9E57BB6035@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <A9E0A66D-CE6F-4A55-80FD-5D9E57BB6035@freescale.com>
Cc: thomas@schnuerer-online.de,
	linuxppc-embedded list <linuxppc-embedded@ozlabs.org>
Subject: Re: [linuxppc] 2.6.12-3 header <asm/usb.h> missing ?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 09, 2005 at 09:50:50AM -0500, Kumar Gala wrote:
> Why are we bothering with asm-ppc/usb.h anyways?
> 
> The structure defn only appears to be used once.  If this is true,  
> why not just define it in the .c file.
> 

Yeah, I think we should stop that unneeded creation of include files 
which are used only once.

For some strange reason people like doing this, I wonder why. Maybe 
they were taught this "style" in their CS classes :)?

-- 
Eugene
