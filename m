Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CCA7DDDDEC
	for <linuxppc-dev@ozlabs.org>; Sun, 16 Nov 2008 08:01:21 +1100 (EST)
Subject: Re: USB problems in 2.6.28-rc*
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sean MacLennan <smaclennan@pikatech.com>
In-Reply-To: <20081115144243.02ec88d0@lappy.seanm.ca>
References: <20081115144243.02ec88d0@lappy.seanm.ca>
Content-Type: text/plain
Date: Sun, 16 Nov 2008 08:01:15 +1100
Message-Id: <1226782875.7178.164.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2008-11-15 at 14:42 -0500, Sean MacLennan wrote:
> Anybody else seeing USB problems in the 2.6.28 kernels? The warp has a
> USB 1.1 port off the 440EP processor. 
> 
> In 2.6.26 we had some problems with certain USB keys, but 2.6.27 fixed
> it. However, the 2.6.28 stream broke it again before rc1. We get this
> twice when you try to use the usb key:

Please reports this to the linux-usb mailing list ! (You can keep this
list on CC but the main people capable to help you are over there)

Cheers,
Ben.

> sd 0:0:0:0: [sda] 990865 512-byte hardware sectors: (507 MB/483 MiB)
> sd 0:0:0:0: [sda] Write Protect is off
> sd 0:0:0:0: [sda] Assuming drive cache: write through
>  sda: sda1
> sd 0:0:0:0: [sda] Attached SCSI removable disk
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> usb 1-1: reset full speed USB device using ppc-of-ohci and address 2
> sd 0:0:0:0: timing out command, waited 60s
> 
> It then seems to work. I haven't looked into it too much since we
> aren't switching to 2.6.28 anytime soon (it breaks our Secure Digital
> card driver).
> 
> But I am hoping somebody might know a quick fix... something like "have
> you got CONFIG_x set" type answer ;)
> 
> Cheers,
>    Sean
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
