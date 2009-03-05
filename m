Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5AF87DDDF6
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Mar 2009 10:34:52 +1100 (EST)
Message-ID: <49B06197.8010007@freescale.com>
Date: Thu, 05 Mar 2009 17:34:47 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: clean up ssi.txt, add definition for fsl,
	ssi-asynchronous
References: <1236295403-11954-1-git-send-email-timur@freescale.com>
In-Reply-To: <1236295403-11954-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> +- fsl,ssi-asynchronous:
> +                    If specific, the SSI is to be programmed in asynchronous
> +                    mode.  In this mode, SRCK and STCK must be connected to the
> +                    same clock, and SRFS and STFS must also be connected to the
> +                    same clock.  This allows playback and capture to use
> +                    different sample sizes.

s/specific/specified/

Does the above mean "SRCK, STCK, SRFS, and STFS must all be connected to 
the same clock", or does it mean "SRCK must be connected to the same 
clock as STCK, and SRFS must be connected to the same clock as STFS"?

-Scott
