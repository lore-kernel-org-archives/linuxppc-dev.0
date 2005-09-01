Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.239.214.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 78ADB6814D
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 19:00:05 +1000 (EST)
Date: Thu, 1 Sep 2005 10:53:19 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Message-ID: <20050901085319.GB6285@isilmar.linta.de>
References: <20050830024840.GA5381@dmt.cnet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050830024840.GA5381@dmt.cnet>
Cc: Russell King <rmk+lkml@arm.linux.org.uk>, linux-kernel@vger.kernel.org,
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

Hi,

On Mon, Aug 29, 2005 at 11:48:40PM -0300, Marcelo Tosatti wrote:
> Russell: The driver is using pccard_nonstatic_ops for card window
> management, even though the driver its marked SS_STATIC_MAP (using
> mem->static_map).

This is obviously broken. Where does it fail if pccard_static_ops is used?

> +typedef struct  {
> +	u_int regbit;
> +	u_int eventbit;
> +} event_table_t;

No typedefs, please.

	Dominik
