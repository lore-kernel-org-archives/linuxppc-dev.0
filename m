Return-Path: <tlopez@aotek.es>
Received: from smtp-out1b.sarenet.es (smtp-out1b.sarenet.es [194.30.18.11])
	by ozlabs.org (Postfix) with ESMTP id 8F48FDDF9C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 22:41:21 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp-out1b.sarenet.es (Postfix) with ESMTP id E268C6D5E8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 14:41:18 +0200 (CEST)
Message-ID: <4631EF88.3060808@aotek.es>
Date: Fri, 27 Apr 2007 14:41:44 +0200
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: Asier Llano Palacios <a.llano@usyscom.com>
Subject: Re: mpc5200 and spi bus
References: <1177595421.9950.4.camel@a.llano.llano>
	<4630BBF9.7000305@aotek.es> <1177670193.9950.9.camel@a.llano.llano>
In-Reply-To: <1177670193.9950.9.camel@a.llano.llano>
Content-Type: multipart/mixed;
	boundary=------------070108010404030806020708
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

This is a multi-part message in MIME format.
--------------070108010404030806020708
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Asier Llano Palacios wrote:

>I'm working with the a linux 2.6.20.9 with patches from Sylvain's tree.
>I've been looking the Den'x 2.5.xx SPI support and it seems that it is
>done through GPIOs. 
>
¿2.5.xx?. I talked about a 2.4.xx version.

>I'd like a native SPI implementation, using the
>hardware of the MPC5200, because of the performance issue of using a
>GPIO, because I'd like to use it at full speed.
>
>Is it done really with GPIOs? If so, is there any other implementation?
>  
>
Yes, you can use the MPC5200's dedicated SPI (spi-algo-mpc5xxx.c) or use 
a PSC in SPI codec mode (spi-algo-mpc5xxx-psc.c).

>If it is possible I'd like it to be for 2.6.x.
>  
>
I don't know nothing about the MPC5200 SPI implementation in the 2.6.x 
kernel.

Best regards,


--------------070108010404030806020708
Content-Type: text/x-vcard; charset=utf-8;
 name="tlopez.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="tlopez.vcf"

begin:vcard
fn:Jose Maria Lopez
n:Lopez;Jose Maria
org:Fagor Automation S. Coop.
adr:;;San Andres 19. Apdo. 144;Arrasate-Mondragon;;20500;Spain
email;internet:tlopez@aotek.es
title:Sotware engineer
tel;work:(34) 943719200
tel;fax:(34) 943791712 
x-mozilla-html:FALSE
url:http://www.fagorautomation.es
version:2.1
end:vcard


--------------070108010404030806020708--
