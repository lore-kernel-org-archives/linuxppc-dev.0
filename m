Return-Path: <tlopez@aotek.es>
Received: from smtp3.sarenet.es (smtp3.sarenet.es [194.30.18.5])
	by ozlabs.org (Postfix) with ESMTP id F2776DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 01:18:46 +1000 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp3.sarenet.es (Postfix) with ESMTP id D7971E7E3C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Apr 2007 16:48:43 +0200 (CEST)
Message-ID: <4630BBF9.7000305@aotek.es>
Date: Thu, 26 Apr 2007 16:49:29 +0200
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: Asier Llano Palacios <a.llano@usyscom.com>
Subject: Re: mpc5200 and spi bus
References: <1177595421.9950.4.camel@a.llano.llano>
In-Reply-To: <1177595421.9950.4.camel@a.llano.llano>
Content-Type: multipart/mixed;
	boundary=------------080106000504030001030104
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
--------------080106000504030001030104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Asier Llano Palacios wrote:

>I've seen some comments about drivers for SPI of the MPC5200. I'm not
>sure about it, but is there anything functional about it?. I want to
>know if there is anything already done, in order to use it or improve
>it. I need a driver of the SPI bus, so if it is not implemented at all
>we should contribute it.
>
>  
>
The Denx's 2.4.xx top of tree kernel has MPC5200 SPI support. We are 
using the SPI dev interface from a user aplication and it works fine.


--------------080106000504030001030104
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


--------------080106000504030001030104--
