Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A09116884E
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Nov 2005 18:03:36 +1100 (EST)
In-Reply-To: <438D4A03.4060500@compulab.co.il>
References: <438C8E8E.3030306@cpe.fr> <438D4A03.4060500@compulab.co.il>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E3409EA9-80FF-4CFF-BF39-F2DE3BA4A609@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 30 Nov 2005 01:03:32 -0600
To: Mike Rapoport <mike@compulab.co.il>
Cc: linuxppc-embedded@ozlabs.org, Nathael PAJANI <nathael.pajani@cpe.fr>
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


On Nov 30, 2005, at 12:43 AM, Mike Rapoport wrote:

> Nathael PAJANI wrote:
>
>> Hi all!
>>
>>
>> I have to support USB hcd for an Actis board based on a MPC8248  
>> processor. I already have a 2.6.9 linux kernel running fine on it,  
>> and actualy have to use it rather than a newer one.
>> I'm actualy looking for existing or ongoing jobs.
>
> Dear Nathael,
> As far as I understand there are several drivers for the MPC8272  
> usb host controller, and none of them is in
> official kernel tree.
> There's a driver in Metrowerks BSP for linux 2.6 for MPC8272 (the  
> Freescale driver), an orignally mpc8xx driver by Brad Parker ported  
> to linux 2.4 for MPC8272 by Pantelis Antoniou, there ought to be  
> USB driver by ArabellaSW also.
> My driver ("http://cpm2usb.sourceforge.net./") is a port of the  
> Brad Parker's driver to linux 2.6 with some modifications.

And, ideally we would like to see one driver get into the linux  
source tree that everyone is happy with.  I'm told by someone that  
the FSL driver is suppose to have working host support "was tested/ 
verified with keyboard/mouse/diskdrives/network".

- kumar
