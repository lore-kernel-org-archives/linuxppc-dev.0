Return-Path: <tlopez@aotek.es>
Received: from smtp1.sarenet.es (smtp1.sarenet.es [194.30.0.4])
	by ozlabs.org (Postfix) with ESMTP id 43764DDD06
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 13 Mar 2007 04:15:08 +1100 (EST)
Received: from ntvir (unknown [212.81.206.17])
	by smtp1.sarenet.es (Postfix) with ESMTP id 86A14120ED
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 12 Mar 2007 17:48:30 +0100 (CET)
Message-ID: <45F58503.30604@aotek.es>
Date: Mon, 12 Mar 2007 17:51:15 +0100
From: Txema Lopez <tlopez@aotek.es>
MIME-Version: 1.0
To: amoll@ganssloser.com
Subject: Re: MPC5200B TxRTS auto-toggle mode. (Txema Lopez)
References: <OF0886F27A.F554CD9A-ONC125729C.004BF911-C125729C.004C7652@avat.
	local>
In-Reply-To: <OF0886F27A.F554CD9A-ONC125729C.004BF911-C125729C.004C7652@avat
	.local>
Content-Type: multipart/mixed;
	boundary=------------010900080501080905050605
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
--------------010900080501080905050605
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Albrecht Moll wrote:


>For your particular case it probably makes more sense to use the TxEMP
>interrupt of the PSC and deassert RTS manually in the interrupt
>service routine.
>  
>
Thanks Albrecht, this has been my approach. I have tested it in a custom 
board and It works. I'have put the patch for a 2.4.xx version in my work 
pipeline.




--------------010900080501080905050605
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


--------------010900080501080905050605--
