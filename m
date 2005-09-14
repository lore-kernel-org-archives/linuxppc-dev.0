Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (mail.dvmed.net [216.237.124.58])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 40FD568263
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 15 Sep 2005 04:46:19 +1000 (EST)
Message-ID: <43286FEF.6020705@pobox.com>
Date: Wed, 14 Sep 2005 14:46:07 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
References: <20050830024840.GA5381@dmt.cnet>
	<20050901085319.GB6285@isilmar.linta.de>
	<20050914141131.GA6830@dmt.cnet>
	<20050914142746.GA14742@isilmar.linta.de>
	<20050914182136.GE6783@dmt.cnet>
In-Reply-To: <20050914182136.GE6783@dmt.cnet>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Magnus Damm <magnus.damm@gmail.com>, linux-kernel@vger.kernel.org,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] MPC8xx PCMCIA driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marcelo Tosatti wrote:
> Here is an uptodated version of the MPC8xx PCMCIA driver for v2.6,
> addressing comments by Jeff and Dominik:
> 
> - use IO accessors instead of direct device memory referencing
> - avoid usage of non-standard "uint/uchar" data types
> - kill struct typedef's
> 
> Will submit it for inclusion once v2.6.14 is out. 
> 
> Testing on 8xx platforms is more than welcome! Works like a charm 
> on our custom hardware (CONFIG_PRxK).

No complaints here...

	Jeff
