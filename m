Return-Path: <mike@compulab.co.il>
Received: from alexmail (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id 9CB5568858
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 17:45:47 +1100 (EST)
Message-ID: <438D4A03.4060500@compulab.co.il>
Date: Wed, 30 Nov 2005 08:43:15 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: Nathael PAJANI <nathael.pajani@cpe.fr>
References: <438C8E8E.3030306@cpe.fr>
In-Reply-To: <438C8E8E.3030306@cpe.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: USB on MPC8272
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Nathael PAJANI wrote:

> Hi all!
>
>
> I have to support USB hcd for an Actis board based on a MPC8248 
> processor. I already have a 2.6.9 linux kernel running fine on it, and 
> actualy have to use it rather than a newer one.
> I'm actualy looking for existing or ongoing jobs.

Dear Nathael,
As far as I understand there are several drivers for the MPC8272 usb 
host controller, and none of them is in
official kernel tree.
There's a driver in Metrowerks BSP for linux 2.6 for MPC8272 (the 
Freescale driver), an orignally mpc8xx driver by Brad Parker ported to 
linux 2.4 for MPC8272 by Pantelis Antoniou, there ought to be USB driver 
by ArabellaSW also.
My driver ("http://cpm2usb.sourceforge.net./") is a port of the Brad 
Parker's driver to linux 2.6 with some modifications.


-- 
Sincerely yours,
Mike Rapoport
