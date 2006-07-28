Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 5CE2267B70
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 29 Jul 2006 06:07:43 +1000 (EST)
To: "Furxhi, Orges" <Orges.Furxhi@thyssenkrupp.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: USB flashdrive on Motorola MPC5200 (IceCube) board,
	linux kernel 2.4.25 (DENX drop)
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Jul 2006 09:53:37 CDT."
	<162B449665D6D643AD9E1D50FC6F4B14042F1C93@mdcexc05.na.ops.local>
Date: Fri, 28 Jul 2006 22:07:40 +0200
Sender: wd@denx.de
Message-Id: <20060728200740.50B3B353C33@atlas.denx.de>
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

Dear Orges,

in message <162B449665D6D643AD9E1D50FC6F4B14042F1C93@mdcexc05.na.ops.local> you wrote:
> 
> I have a LITE5200 Version 2.0 board and I have loaded the latest DENX drop
> of the 2.4 kernel on it. When I plug in the usb flash drive I get the
> following message:
> 
> Usb.c: USB device not accepting new address=4 (error=-110)   
> Usb.c: USB device not accepting new address=5 (error=-110)
> 
> I must be doing something wrong, and I do not know what it is.

Are you just trying one specific type opf USB device,  or  does  this
happen with several 5 or more) different devices?

> You said that you had the same board and kernel and that your USB as mass
> storage was working. Could you please send me your kernel's .config file so
> that I can compare it with mine? 

You can just use the  default  configuration  as  provided  with  the
kernel  tree.  Make  sure to use a current kernel (top of tree in git
repo).

And keep in mind  that  many  USB  devices  are  simply  not  strctly
standard conforming. Some will work, others won't.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The biggest difference between time and space is that you can't reuse
time.                                                 - Merrick Furst
