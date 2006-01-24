Return-Path: <tnt@246tNt.com>
Received: from outmx026.isp.belgacom.be (outmx026.isp.belgacom.be
	[195.238.4.91])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 24E0C681BD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Jan 2006 05:17:58 +1100 (EST)
Received: from outmx026.isp.belgacom.be (localhost [127.0.0.1])
	by outmx026.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id k0OIHl0Z002268
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jan 2006 19:17:48 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <43D66F54.8000404@246tNt.com>
Date: Tue, 24 Jan 2006 19:17:56 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH] Add support for lite5200b board.
References: <43D65FE3.6080501@freescale.com>
In-Reply-To: <43D65FE3.6080501@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi John,

John Rigby wrote:
> Sylvain,
>
> Here is an updated patch for the liteb board.
>
> John


Looks good. But two comments :

 * Isn't a modif to the arch/ppc/platform/Makefile missing ?
 * What's the "cs-1" you turn on there :

>  
> +#ifdef CONFIG_LITE5200B
> +	/* turn on cs1 */
> +	port_config |= 0x80000000;
> +#endif

	I couldn't find the schema / real-doc of the Lite5200b,
is this available somewhere on-line ?




	Sylvain
