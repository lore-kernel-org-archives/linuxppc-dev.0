Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8A9368033
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Aug 2005 02:09:01 +1000 (EST)
Date: Tue, 23 Aug 2005 20:33:18 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Andy Fleming <afleming@freescale.com>
Message-ID: <20050823233318.GA16787@dmt.cnet>
References: <20050823202708.GE13157@dmt.cnet>
	<1124836787.5189.107.camel@gaston>
	<29D5FC3D-C2AD-440E-B929-9AA29F7300CF@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <29D5FC3D-C2AD-440E-B929-9AA29F7300CF@freescale.com>
Cc: Kumar Gala <galak@freescale.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: make perfmon.o CONFIG_E500 specific
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Aug 23, 2005 at 05:50:15PM -0500, Andy Fleming wrote:
> I've got some untested code for 74xx (probably only 7450 for now),  
> but it's several rungs down my priority list right now.  : 
> (  Hopefully I will have time for it soon...

OK - you can then add the proper change for inclusion inside
the #ifdef ?

Please apply the patch (or some variant of it).
