Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6F53EDDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 May 2007 07:27:01 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	l47LQumK007645
	for <linuxppc-dev@ozlabs.org>; Mon, 7 May 2007 14:26:57 -0700 (MST)
In-Reply-To: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
References: <20070507182947.GD26920@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B7081C3F-C551-42D8-BB5D-6FE5DC311C99@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH 05/13] Document the fsl,
	magic-packet property in gianfar nodes.
Date: Mon, 7 May 2007 16:27:05 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 7, 2007, at 13:29, Scott Wood wrote:

> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  Documentation/powerpc/booting-without-of.txt |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
>
> diff --git a/Documentation/powerpc/booting-without-of.txt b/ 
> Documentation/powerpc/booting-without-of.txt
> index 0efd8a0..1cd29e1 100644
> --- a/Documentation/powerpc/booting-without-of.txt
> +++ b/Documentation/powerpc/booting-without-of.txt
> @@ -1187,6 +1187,10 @@ platforms are moved over to use the  
> flattened-device-tree model.
>        MAC addresses passed by the firmware when no information other
>        than indices is available to associate an address with a  
> device.
>
> +   Optional properties:
> +    - fsl,magic-packet : Indicates that this device supports wake
> +      on Magic Packet.
> +

Isn't this a fairly generic option?  Does it need the "fsl" qualifier?

Andy
