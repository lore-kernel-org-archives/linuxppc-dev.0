Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E210A67B51
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  3 May 2006 04:19:21 +1000 (EST)
In-Reply-To: <DDBD7B17DB2ECE48BCD94C593F7255B401551C7A@monk.echelon.echcorp.com>
References: <DDBD7B17DB2ECE48BCD94C593F7255B401551C7A@monk.echelon.echcorp.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A87202B7-1650-4282-ADBE-E924F8B5D8CA@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: USB on MPC8349EMDS
Date: Tue, 2 May 2006 13:19:12 -0500
To: "Prashant Viswanathan" <vprashant@echelon.com>
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


On May 2, 2006, at 12:57 PM, Prashant Viswanathan wrote:

> Hi,
>
> I have linux kernel (2.6.11) from Freescale running on the  
> MPC8349EMDS.
> I am using the BSP from Freescale which is supposed to have USB  
> support.
>
> However, I seem to be having problems with USB host support.
>
> When I insert a USB Mass storage device (thumb drive), I get the
> following errors
>
> / #  usb 1-2: new high speed USB device using fsl-usb2-mph and  
> address 8
> usb 1-2: khubd timed out on ep0in
> usb 1-2: new high speed USB device using fsl-usb2-mph and address 9
> usb 1-2: khubd timed out on ep0in
>
> It does not show up in /proc/bus/usb/devices (I do have usbfs  
> mounted).
>
> I also have usb-utils installed and lsusb fails to list the device.
>
> I have also tried other USB devices and get similar errors.
>
> Has anybody else experience similar problems? Any pointers/help  
> will be
> appreciated.

I know there are some bugs in the Freescale driver that was released  
as part of their BSP.

Are you using a PMC2USB module or just the USB ports on the SYS card?

- k
