Return-Path: <andrew.dennison@motec.com.au>
Received: from mail.netspace.net.au (cumulus.netspace.net.au [203.10.110.72])
	by ozlabs.org (Postfix) with ESMTP id 67D7967AD0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 09:16:23 +1100 (EST)
Received: from motec.com.au (dsl-210-15-234-78.VIC.netspace.net.au
	[210.15.234.78])
	by mail.netspace.net.au (Postfix) with SMTP id 5F8C270E59
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Feb 2005 09:16:22 +1100 (EST)
From: "Andrew Dennison" <andrew.dennison@motec.com.au>
To: "'Eric N. Johnson (ACD)'" <ejohnson@acdstar.com>
Date: Thu, 10 Feb 2005 09:16:23 +1100
Message-ID: <002601c50ef4$fd1ef240$4000a8c0@CAT>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <20050209203314.78351C108D@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC5200 JTAG/BDM Flash Burning 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On , linuxppc-embedded-bounces@ozlabs.org wrote:

> In message
> <6.2.1.2.1.20050209131409.02b2b718@mail.int.acdstar.com> you wrote:
>> I'm working on a custom MPC5200 board based heavily on the IceCube
>> design from Motorola/Freescale.  We plan to use the u-boot
>> bootloader.=20
>>=20
>> I'm looking for a tool to allow us to burn u-boot into the flash
>> memory on new board (with all flash devices unprogrammed).  Ideally,
>> I'd like=20
>=20
> If you consider the fact that besides fash burning you may also  want
> to  have  a  working hardware debugger, you should go for a BDI2000 -
> especially for Linux, when MMU support is needed.

Get the BDI2000. I'm very glad Wolfgang talked me into it!

Use the Slingshot and Wiretap as paperweights.
