Return-Path: <marcelo.tosatti@cyclades.com>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1F31967EF3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  6 Aug 2005 06:40:37 +1000 (EST)
Date: Fri, 5 Aug 2005 17:34:56 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pantelis Antoniou <pantelis.antoniou@gmail.com>
Message-ID: <20050805203456.GD14338@dmt.cnet>
References: <200508021909.45729.pantelis.antoniou@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200508021909.45729.pantelis.antoniou@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] cpm_uart: make dpram allocation actually work
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Aug 02, 2005 at 07:09:45PM +0300, Pantelis Antoniou wrote:
>   Hi Marcelo
> 
> While the idea of allocating console buffers from dpram is sound, 
> the initial implementation didn't actually work :)
> 
> The following patch fixes it (tested and booted on 2.6.13-rc4).

OK thanks Panto. 

Despite my limited knowledge here, Vitaly's merged patch looks fine.

I suppose someone (Kumar?) is going to send it upstream now? 
