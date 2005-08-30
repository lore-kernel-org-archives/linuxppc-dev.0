Return-Path: <rmk+linuxppc-embedded=ozlabs.org@arm.linux.org.uk>
Received: from parcelfarce.linux.theplanet.co.uk
	(parcelfarce.linux.theplanet.co.uk [195.92.249.252])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABF5268194
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Aug 2005 17:06:58 +1000 (EST)
Received: from [2002:d412:e8ba::1] (helo=caramon.arm.linux.org.uk)
	by parcelfarce.linux.theplanet.co.uk with esmtpsa
	(TLSv1:DES-CBC3-SHA:168) (Exim 4.43) id 1EA0Fq-0006ej-7F
	for linuxppc-embedded@ozlabs.org; Tue, 30 Aug 2005 08:09:58 +0100
Date: Tue, 30 Aug 2005 08:06:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050830080626.A19060@flint.arm.linux.org.uk>
References: <20050830024840.GA5381@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050830024840.GA5381@dmt.cnet>;
	from marcelo.tosatti@cyclades.com on Mon, Aug 29, 2005 at
	11:48:40PM -0300
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org,
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

On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> Here goes the 8xx PCMCIA driver, originally written by Magnus Damm, with
> several improvements and fixes.

Please don't copy me on PCMCIA stuff - I don't look after PCMCIA anymore.
Please use the linux-pcmcia mailing list on lists.infradead.org.  Thanks.

> Russell: The driver is using pccard_nonstatic_ops for card window
> management, even though the driver its marked SS_STATIC_MAP (using
> mem->static_map).
> 
> Otherwise card IO windows aren't allocated properly.

This seems very wrong.  Are you suggesting that IO windows need to be
dynamic and memory windows static?  If so, the pcmcia code isn't
designed to cope with that.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
