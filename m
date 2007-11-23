Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CEEBDDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Nov 2007 19:45:55 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IvUAZ-0001uE-Vt
	for linuxppc-embedded@ozlabs.org; Fri, 23 Nov 2007 00:45:51 -0800
Message-ID: <13908701.post@talk.nabble.com>
Date: Fri, 23 Nov 2007 00:45:51 -0800 (PST)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Firmware Support for USB Hub
In-Reply-To: <13877282.post@talk.nabble.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <13877282.post@talk.nabble.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is the reply that i got from the Freescale :-

--------------------------------------------------------------------------
Reply from Freescale 
In reply to your Service Request SR 1-403672820:

We recommend using the MPC8272 USB controller.
We know that customers use the MPC8272/MPC8248 USB controller.
You can find also USB drivers in Linux software for the MPC8272.
For example Linux BSP for Freescale MPC8272ADS contains USB slave 
driver 
(http://www.freescale.com/webapp/sps/site/overview.jsp?nodeId=0127260061033202A5).

Linux USB driver is available in the Arabella Linux 
(http://www.arabellasw.com/products-pow2.php).

If the MPC8272 is USB host, the transaction-level interface can be used.

Note: The MPC8272 USB does not support high-speed mode. It can 
operate on low-speed mode (1.5MHz) or full-speed mode (12MHz).

------------------------------------------------------------------------------------------

Can any body comment on this and help me how to start with and requirement
is this :-

I need a USB Hub to be connected to the PPC8248 board with Montavista Linux
2.6.10 
on it what shall i do to achive it ....????The challenges you already know 

Hoping for the the Help ...




Misbah khan wrote:
> 
> Hi all,
> 
> I am using a 8248 processor which has a USB controller and i need to
> connect a USB Hub to it, iam using Montavista Linux .I need to know that
> what are the support i need form Montavista or Open source to have an
> interface with Usb hub. ???
> 
> Is there any driver that we need to make if so what type ???
> 
> --misbah <><
> 

-- 
View this message in context: http://www.nabble.com/Firmware-Support-for-USB-Hub-tf4850180.html#a13908701
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
