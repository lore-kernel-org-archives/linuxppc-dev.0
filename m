Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2EE54686B9
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  7 Nov 2005 07:42:26 +1100 (EST)
To: bennett78@digis.net
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 05 Nov 2005 12:22:50 MST."
	<436D068A.7030905@digis.net>
Date: Sun, 06 Nov 2005 21:42:24 +0100
Sender: wd@denx.de
Message-Id: <20051106204224.12A52352674@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200 I2S driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <436D068A.7030905@digis.net> you wrote:
> 
> I am developing a couple of drivers: one a Data
> Acquisition driver for SPI based AD7683 SAR ADC
> on PSC6/codec and a LCD user interface on PSC3/SPI
> using the DENX Linux distribution. Is arch/ppc/5xxx_io/i2s.c
> a good example of a Bestcomm, Codec, non Ethernet
> example?

The  arch/ppc/5xxx_io/i2s.c  driver  is  *not*  a  good  example  for
anything  usefuil - it is test code used to demonstrate some problems
with (earlier versions of) the BestComm API code.  It  is  not  in  a
working state.

An example for a working driver is in  "i2s_ring.c",  but  note  that
this  driver  uses a pretty specialized interface to the application,
so you will probably have to adjust this for your needs.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Be careful what you wish for. You never know who will be listening.
                                      - Terry Pratchett, _Soul Music_
