Return-Path: <wd@denx.de>
Received: from mailout08.sul.t-online.com (mailout08.sul.t-online.com
	[194.25.134.20]) by ozlabs.org (Postfix) with ESMTP id 2CFB067A74
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Feb 2005 09:45:44 +1100 (EST)
To: David Ho <DavidHo@nanometrics.ca>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 01 Feb 2005 11:47:02 EST."
	<OFAA7E66FB.78AF3A29-ON85256F9B.005B85BD-85256F9B.005C32E2@nanometrics.ca>
Date: Tue, 01 Feb 2005 23:45:14 +0100
Sender: wd@denx.de
Message-Id: <20050201224519.33493C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Testing ISP1362 USB network device driver. 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear David,

in message <OFAA7E66FB.78AF3A29-ON85256F9B.005B85BD-85256F9B.005C32E2@nanometrics.ca> you wrote:
> 
> I'm testing the device side of the ISP1362 using your USB network driver.
> I can get a PC to enumerate with the 1362 but then I don't have a windows
> driver to route IP traffic to it.  I'm just curious how you test the
> driver?  Do you have a Linux host side driver to communicate with the 1362
> as a USB NIC device?

We used a standard Linux PC with the "usbnet" driver (at the time  of
our  tests  under  RH-7.1  running  kernel  version 2.4.20-19.7); our
customer also verified  operation  using  the  Bahia  Network  Driver
release 0.9beta under Windows XP (we couldn't do these tests as we're
a 100% M$-free company :-).
