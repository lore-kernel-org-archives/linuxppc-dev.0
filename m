Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 39BD62BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Nov 2004 11:27:38 +1100 (EST)
Date: Wed, 3 Nov 2004 16:27:34 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Rick McBain <rick.mcbain@logicsense.com>
Message-ID: <20041104002734.GA4063@gate.ebshome.net>
References: <002b01c4c1fb$49adde60$6802a8c0@RicksPresario900>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <002b01c4c1fb$49adde60$6802a8c0@RicksPresario900>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Linux port for the AMCC (was IBM) 440EP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Nov 03, 2004 at 03:17:27PM -0800, Rick McBain wrote:
> Does anybody have a working distribution for the 440EP? We were planning
> to use a Timesys port, but we've now been told it doesn't exist (after
> months of promises it did.).  Our other option is to pay US$25K to
> MontaVista, but that seems a tad pricey, and our previous experience
> with them is that they delivered us an ARM port which fundamentally
> didn't work.
> 

Just FYI, 44x port was made by MontaVista.

Try the following exercise, grep the kernel code and see how much was 
written for PPC by Timesys and then make your decision.

FWIW, it should be relatively simple to do 440EP port, we already 
have working 440GP & 440GX in both 2.4 & 2.6.

--
Eugene.
