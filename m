Return-Path: <BLandau@nds.com>
Received: from ilsmtp.nds.com (ilsmtp.nds.com [192.118.32.12])
	by ozlabs.org (Postfix) with ESMTP id 36465DDDB6
	for <linuxppc-dev@ozlabs.org>; Tue,  5 May 2009 16:15:59 +1000 (EST)
From: "Landau, Bracha" <BLandau@nds.com>
To: Scott Wood <scottwood@freescale.com>
Date: Tue, 5 May 2009 09:16:28 +0300
Subject: RE: help with MPC8272ADS board
Message-ID: <065A7D06F7D4E546A18E80E08D066E18118931C627@ILMA1.IL.NDS.COM>
In-Reply-To: <20090504163055.GA16637@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've upgraded to the latest kernel (2.6.29), and after updating the configu=
ration the cuImage did boot.
What's the difference between the address for the early debug console for c=
uImage and uImage + blob?


-----Original Message-----
From: Scott Wood [mailto:scottwood@freescale.com]
Sent: Monday, May 04, 2009 7:31 PM
To: Landau, Bracha
Cc: linuxppc-dev@ozlabs.org
Subject: Re: help with MPC8272ADS board

On Sun, May 03, 2009 at 10:16:29AM +0300, Landau, Bracha wrote:
> I'm trying to get the MPC8272ADS evaluation board up and running with
> the latest versions of u-boot and Denx linux (2.6.24).

2.6.24 is nowhere near the latest version of Linux.  If you specifically wa=
nt to use a Denx kernel, you're better off at eldk@denx.de -- though I'd be=
 surprised if that's the latest they offer, either.

> I use the device tree file (mpc8272ads.dts) provided. Based on another
> post, I updated the MPC8260ADS.h file, changing OF_CPU from
> "cpu@0<mailto:cpu@0>" to "PowerPC,8272@0", because I was getting an
> error.

I'd rather change the device tree, instead.

> I tried booting both using a cuImage (cuImage.mpc8272ads) and a uImage
> with a device tree blob. Neither boot was successful, with no helpful
> information printed to the serial port.
>
> Is there any change that has to be made in order to get the board to boot=
?

Upgrade to the latest kernel, and if it still doesn't work try enabling the=
 early debug console (note that the default address is currently for cuImag=
e).

-Scott

This e-mail is confidential, the property of NDS Ltd and intended for the a=
ddressee only. Any dissemination, copying or distribution of this message o=
r any attachments by anyone other than the intended recipient is strictly p=
rohibited. If you have received this message in error, please immediately n=
otify the postmaster@nds.com and destroy the original message. Messages sen=
t to and from NDS may be monitored. NDS cannot guarantee any message delive=
ry method is secure or error-free. Information could be intercepted, corrup=
ted, lost, destroyed, arrive late or incomplete, or contain viruses. We do =
not accept responsibility for any errors or omissions in this message and/o=
r attachment that arise as a result of transmission. You should carry out y=
our own virus checks before opening any attachment. Any views or opinions p=
resented are solely those of the author and do not necessarily represent th=
ose of NDS.

To protect the environment please do not print this e-mail unless necessary=
.

NDS Limited Registered Office: One London Road, Staines,Middlesex TW18 4EX,=
 United Kingdom. A company registered in England and Wales Registered no. 3=
080780 VAT no. GB 603 8808 40-00
