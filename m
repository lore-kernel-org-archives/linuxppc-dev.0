Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DDA68DDEFE
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 02:10:21 +1000 (EST)
Date: Mon, 7 Apr 2008 11:10:36 -0500
From: Scott Wood <scottwood@freescale.com>
To: =?iso-8859-1?Q?Andr=E9?= Schwarz <Andre.Schwarz@matrix-vision.de>
Subject: Re: MPC8343 - "unable to handle paging request @ 0"
Message-ID: <20080407161036.GA2688@loki.buserror.net>
References: <47F73625.9040903@matrix-vision.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <47F73625.9040903@matrix-vision.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Apr 05, 2008 at 10:19:49AM +0200, André Schwarz wrote:
> Kernel starts and crashes with "unable to handle kernel paging request @  
> 00000000".
>
> After turning debug on in some files I can see that the initrd memory  
> gets reserved and the dtb is parsed correctly.
> PCI memory/io spaces are set up fine.
>
> At first I thought this is a problem with the device tree since the call  
> trace always points to "of_"-functions and "strcmp".

Could you provide this call trace?

-Scott
